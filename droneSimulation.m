figure('Position', [0 0 600 400])

%axis vis3d

cam=[1:length(x.data)]
% Set the aspect ratio of the plot
axes('PlotBoxAspectRatio', [2 2 1])
hold on % Add this line to keep the points and the line on the same plot
cla
% Initialize an empty array for the line data
line_data = [];

% Capture a single frame with the desired size
template_frame = getframe(gcf, [0 0 600 400]);

% Initialize the MM array using the template frame
MM = repmat(template_frame, length(x.data), 1);

for i=1:length(x.data)
    % Clear the current axes
    cla
    % Add the current point to the line data array
    line_data = [line_data; [x.data(i) y.data(i) z.data(i)]];
    % Plot the line using the line data array
    h1 = plot3(line_data(:,1), line_data(:,2), line_data(:,3), 'Color', 'r', 'LineWidth', 1,'LineStyle', '-.', 'DisplayName', 'Trajectory');
    % Plot the current point as a scatter plot
    h2 = scatter3([x.data(i)],[y.data(i)],[z.data(i)],120,'k','*','DisplayName','Simulated drone','LineWidth',5);
    xlim([0 max(x.data)+1])
    ylim([0 max(y.data)+1])
    zlim([0 max(z.data)+1])
    grid on
  
    xlabel('X axis (m)', 'FontSize', 14);
    ylabel('Y axis (m)', 'FontSize', 14);
    zlabel('Z axis (m)', 'FontSize', 14);
    view(3) %cam(i)*0.4+65,cam(i)*0.6+30
    % Add the legend
    legend({ 'Trajectory','Simulated drone'}, 'Location', 'NorthEast' ,'FontSize', 14)
    pause(0.1)
    
    MM(i).cdata=getframe(gcf).cdata;
    cla
end
figure
% xy view
subplot(1, 2, 1)
plot(x.data, y.data, 'r', 'LineWidth', 2)
xlabel('X axis (m)', 'FontSize', 14)
ylabel('Y axis (m)', 'FontSize', 14)
grid on

% xz view
subplot(1, 2, 2)
plot(x.data, z.data, 'r', 'LineWidth', 2)
xlabel('X axis (m)', 'FontSize', 14)
ylabel('Z axis (m)', 'FontSize', 14)
grid on
drawnow;

v = VideoWriter('animation.mp4','MPEG-4');
open(v)
writeVideo(v,MM)
close(v)
