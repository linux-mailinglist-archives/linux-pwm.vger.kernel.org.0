Return-Path: <linux-pwm+bounces-2881-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7593872B
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 03:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901511C20CBF
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 01:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606E48BFC;
	Mon, 22 Jul 2024 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="FG+0njog"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEF2611E
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jul 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610520; cv=none; b=uWU8/gMtSD2u9rs9J63XO0mh55gF67zncV+8bwS4ibBxTv/9wF628QT4G1YZ+LRYs2Gk2+gNCPWa7Xv5zwSX9n1J/OKkMV/PUX7IfJOC4rdZ77woByuWr0C4pkNVBg0ggOKHhtm85uzAZUYYrlryfGxjYx/omxsOZYmQtW/1p1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610520; c=relaxed/simple;
	bh=DNyVObbdbJVdi/P6CGl+fix7Tl3TWS/WBFlw4NpsCsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9QxBbOq2kqAp62wePWLDmUpboq+MWKoqjDgiTGe3PD8i0540i7MKJjf9jLhyK39A9IncUposqQG5O9ABK1GfeMIo5QeXxfCQz6NJuT1qOHU1EtUZ9wy0pNJkR+9Ys+xx0451anoSeDw0bNvcZFr6HsOzLFbBWtTfcXCWagfboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=FG+0njog; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 80B312C0E27;
	Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1721609921;
	bh=VV02Np9Kd7WYDspFLZTpFMwWK72ogN13gPcn8ggs8Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FG+0njog8cgOJF/tNziMXmA3EkuYdMrEcl2C4OW9xkG56NP3ZanE6u0OvSBE6z3/N
	 PRRjqJYB+LidqBCa+FtTJ4WaACEs7lvzy4GibHPIRtG3tKyxM7sOD5Z8S1Ssc45uAa
	 n6x5FoUPWuuQ4pVq3G5bnurYITk30RLYk2yh0hlypdxb1CzdF5S8DA2U7TLMr1SMPL
	 r2yefD6Mre2eUU0NpeTwlBpE0JcbGbkyqYCKsjKT7TPSfFoNVMhhb75dEWhrYMcfwG
	 Ep12Z/Ct3XWvCx0neBqrA9aQCkAABzujiLaUy6DQu2KKTlznaMDAUREmjYB+kHZ4Z1
	 wiFT/3BZwTWmA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B669daec10003>; Mon, 22 Jul 2024 12:58:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 40F1413EE85;
	Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 3F403280B00; Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 3/3] hwmon: (adt7475) Add support for configuring initial PWM state
Date: Mon, 22 Jul 2024 12:58:25 +1200
Message-ID: <20240722005825.1800403-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722005825.1800403-1-chris.packham@alliedtelesis.co.nz>
References: <20240722005825.1800403-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gqbh+V1C c=1 sm=1 tr=0 ts=669daec1 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=oTqbJ0pJKTyCvHz9JCwA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

By default the PWM duty cycle in hardware is 100%. On some systems this
can cause unwanted fan noise. Add the ability to specify the fan
connections and initial state of the PWMs via device properties.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v6:
    - Use do_div() instead of plain /
    - Use a helper function to avoid repetition between the of and non-of
      code paths.
    Changes in v5:
    - Deal with PWM frequency and duty cycle being specified in nanosecon=
ds
    Changes in v4:
    - Support DT and ACPI fwnodes
    - Put PWM into manual mode
    Changes in v3:
    - Use the pwm provider/consumer bindings
    Changes in v2:
    - Use correct device property string for frequency
    - Allow -EINVAL and only warn on error
    - Use a frequency of 0 to indicate that the hardware should be left a=
s-is

 drivers/hwmon/adt7475.c | 130 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4224ffb30483..fc5605d34f36 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -21,6 +21,8 @@
 #include <linux/of.h>
 #include <linux/util_macros.h>
=20
+#include <dt-bindings/pwm/pwm.h>
+
 /* Indexes for the sysfs hooks */
=20
 #define INPUT		0
@@ -1662,6 +1664,130 @@ static int adt7475_set_pwm_polarity(struct i2c_cl=
ient *client)
 	return 0;
 }
=20
+struct adt7475_pwm_config {
+	int index;
+	int freq;
+	int flags;
+	int duty;
+};
+
+static int _adt7475_pwm_properties_parse_args(u32 args[4], struct adt747=
5_pwm_config *cfg)
+{
+	unsigned long freq_hz;
+	unsigned long duty;
+
+	if (args[1] =3D=3D 0)
+		return -EINVAL;
+
+	freq_hz =3D 1000000000UL;
+	do_div(freq_hz, args[1]);
+	duty =3D 255 * args[3];
+	do_div(duty, args[1]);
+
+	cfg->index =3D args[0];
+	cfg->freq =3D find_closest(freq_hz, pwmfreq_table, ARRAY_SIZE(pwmfreq_t=
able));
+	cfg->flags =3D args[2];
+	cfg->duty =3D clamp_val(duty, 0, 0xFF);
+
+	return 0;
+}
+
+static int adt7475_pwm_properties_parse_reference_args(struct fwnode_han=
dle *fwnode,
+						       struct adt7475_pwm_config *cfg)
+{
+	int ret, i;
+	struct fwnode_reference_args rargs =3D {};
+	u32 args[4] =3D {};
+
+	ret =3D fwnode_property_get_reference_args(fwnode, "pwms", "#pwm-cells"=
, 0, 0, &rargs);
+	if (ret)
+		return ret;
+
+	if (rargs.nargs !=3D 4) {
+		fwnode_handle_put(rargs.fwnode);
+		return -EINVAL;
+	}
+
+	for (i =3D 0; i < 4; i++)
+		args[i] =3D rargs.args[i];
+
+	ret =3D _adt7475_pwm_properties_parse_args(args, cfg);
+
+	fwnode_handle_put(rargs.fwnode);
+
+	return ret;
+}
+
+static int adt7475_pwm_properties_parse_args(struct fwnode_handle *fwnod=
e,
+					     struct adt7475_pwm_config *cfg)
+{
+	int ret;
+	u32 args[4] =3D {};
+
+	ret =3D fwnode_property_read_u32_array(fwnode, "pwms", args, ARRAY_SIZE=
(args));
+	if (ret)
+		return ret;
+
+	return _adt7475_pwm_properties_parse_args(args, cfg);
+
+}
+
+static int adt7475_fan_pwm_config(struct i2c_client *client)
+{
+	struct adt7475_data *data =3D i2c_get_clientdata(client);
+	struct fwnode_handle *child;
+	struct adt7475_pwm_config cfg =3D {};
+	int ret;
+
+	device_for_each_child_node(&client->dev, child) {
+		if (!fwnode_property_present(child, "pwms"))
+			continue;
+
+		if (is_of_node(child))
+			ret =3D adt7475_pwm_properties_parse_reference_args(child, &cfg);
+		else
+			ret =3D adt7475_pwm_properties_parse_args(child, &cfg);
+
+		if (cfg.index >=3D ADT7475_PWM_COUNT)
+			return -EINVAL;
+
+		ret =3D adt7475_read(PWM_CONFIG_REG(cfg.index));
+		if (ret < 0)
+			return ret;
+		data->pwm[CONTROL][cfg.index] =3D ret;
+		if (cfg.flags & PWM_POLARITY_INVERTED)
+			data->pwm[CONTROL][cfg.index] |=3D BIT(4);
+		else
+			data->pwm[CONTROL][cfg.index] &=3D ~BIT(4);
+
+		/* Force to manual mode so PWM values take effect */
+		data->pwm[CONTROL][cfg.index] &=3D ~0xE0;
+		data->pwm[CONTROL][cfg.index] |=3D 0x07 << 5;
+
+		ret =3D i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(cfg.index),
+						data->pwm[CONTROL][cfg.index]);
+		if (ret)
+			return ret;
+
+		data->pwm[INPUT][cfg.index] =3D cfg.duty;
+		ret =3D i2c_smbus_write_byte_data(client, PWM_REG(cfg.index),
+						data->pwm[INPUT][cfg.index]);
+		if (ret)
+			return ret;
+
+		data->range[cfg.index] =3D adt7475_read(TEMP_TRANGE_REG(cfg.index));
+		data->range[cfg.index] &=3D ~0xf;
+		data->range[cfg.index] |=3D cfg.freq;
+
+		ret =3D i2c_smbus_write_byte_data(client, TEMP_TRANGE_REG(cfg.index),
+						data->range[cfg.index]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int adt7475_probe(struct i2c_client *client)
 {
 	enum chips chip;
@@ -1778,6 +1904,10 @@ static int adt7475_probe(struct i2c_client *client=
)
 	if (ret && ret !=3D -EINVAL)
 		dev_warn(&client->dev, "Error configuring pwm polarity\n");
=20
+	ret =3D adt7475_fan_pwm_config(client);
+	if (ret)
+		dev_warn(&client->dev, "Error %d configuring fan/pwm\n", ret);
+
 	/* Start monitoring */
 	switch (chip) {
 	case adt7475:
--=20
2.45.2


