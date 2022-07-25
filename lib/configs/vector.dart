class Vector {
  int x;
  int y;

  Vector(this.x, this.y);

  operator +(Vector value) {
    x = x + value.x;
    y = y + value.y;
  }

  operator *(int value) {
    x = x * value;
    y = y * value;
  }
}
