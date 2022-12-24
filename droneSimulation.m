%%Data simulation code
figure
axis vis3d
xlabel('X axis (m)')
ylabel('Y axis (m)')
zlabel('Z axis (m)')
cam=[1:length(x.data)]

for i=1:length(x.data)
    scatter3([x.data(i)],[y.data(i)],[z.data(i)],120,'k','*','DisplayName','Simulated drone','LineWidth',5)
    xlim([0 max(x.data)+1])
    ylim([0 max(y.data)+1])
    zlim([0 max(z.data)+1])
    grid on
    line([x.data(i)],[y.data(i)],[z.data(i)])
    xlabel('X axis (m)', 'FontSize', 14);
    ylabel('Y axis (m)', 'FontSize', 14);
    zlabel('Z axis (m)', 'FontSize', 14);
    legend('Simulated drone', 'FontSize', 14)
    view(3) %cam(i)*0.4+65,cam(i)*0.6+30
    pause(0.1)
    MM(i)=getframe(gcf);
end

drawnow;

v = VideoWriter('animation.mp4','MPEG-4');
open(v)
writeVideo(v,MM)
close(v)
