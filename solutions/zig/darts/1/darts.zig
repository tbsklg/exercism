pub const Coordinate = struct {
    x: f32,
    y: f32,

    pub fn init(x_coord: f32, y_coord: f32) Coordinate {
        return Coordinate{
            .x = x_coord,
            .y = y_coord,
        };
    }

    pub fn score(self: Coordinate) usize {
        const distance = self.x * self.x + self.y * self.y;

        if (distance <= 1) return 10;
        if (distance <= 25) return 5;
        if (distance <= 100) return 1;

        return 0;
    }
};
