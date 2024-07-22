Return-Path: <linux-pwm+bounces-2904-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9F4939669
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jul 2024 00:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9E72821A9
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C124962C;
	Mon, 22 Jul 2024 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="EWn0kgE8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A6381A4
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jul 2024 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686667; cv=none; b=Zy0QNPMmHHwyOCBs6aCKqQv5vBbTubF5hVwAXjJ1CGAtO9pskrj/413vmTqeGnomzdCt2G7VWcImxHRwbM4rGOQK6JRghoMVAv40GNngo25btCBJAA4ThcX3jDX0UyGe0vM7pI/3QUzmObicgZEbUVnM8JS45tJYZQegwTdZor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686667; c=relaxed/simple;
	bh=zgQebKhinP/7FCvf68WY8nJL2qjueKynlSsbnak7l5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWBORy2bWqBLLDsPhPNQxlNc9gpv3gpV66fN9wxuiJt5dvrhWqWqo4k6r/I1X5n4/gdPBz+J6ngXVzHQRX3WL2DIIx2O+ec+prOqGShILLX3gLUNqAJlVaYabz9UxcslCZEERgKz6R6w9BuWDzcmDCRoD7Y306QcOCV1P37YFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=EWn0kgE8; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E41072C052D;
	Tue, 23 Jul 2024 10:17:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1721686660;
	bh=fnwFGkljgxGDl/iNleDqiwgcBrzacnMXKEd49U7qXuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWn0kgE8b0empuqQMaJ+iJCwoOnVVpsvdc3m8hpVbpjJ4w0PeNv7jDxHvi1/QKR8M
	 LYd98SIcGnZvkCEtHlUJUsLgAiMS8hWm+Q/T5RZETGlWnVIxGyX6sPYZW74vONyXS8
	 2mGeojwt0aLWrGYuxty3MJOqe/dbh+xYMOVDt7q57qy1qfeLfBC3/gk5ae3obdEe6c
	 C2NAWwCQbL7DwSeQm1+yO/dkgQLgwrQuDyvJCOJyG+vVhSZFqyab1U1B1Vk/aKljEz
	 fs9KP6VQqvoz3/NeMA9G6b2GYKeU/OqodQVJMvafSuQ7QTftg7bSeLYIrhMayRAO//
	 uFKMKVXj6cLQQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B669eda840003>; Tue, 23 Jul 2024 10:17:40 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id A976513EE85;
	Tue, 23 Jul 2024 10:17:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id A7A9F280795; Tue, 23 Jul 2024 10:17:40 +1200 (NZST)
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
Subject: [PATCH v7 3/3] hwmon: (adt7475) Add support for configuring initial PWM state
Date: Tue, 23 Jul 2024 10:17:37 +1200
Message-ID: <20240722221737.3407958-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gqbh+V1C c=1 sm=1 tr=0 ts=669eda84 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=tnPpcKm_8nDtnJRuLYIA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

By default the PWM duty cycle in hardware is 100%. On some systems this
can cause unwanted fan noise. Add the ability to specify the fan
connections and initial state of the PWMs via device properties.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v7:
    - Use plain / for freq_hz since this can't overflow. Use div_u64 to
      avoid overflow when calculating duty.
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

 drivers/hwmon/adt7475.c | 131 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 4224ffb30483..2037a4b57031 100644
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
@@ -1662,6 +1664,131 @@ static int adt7475_set_pwm_polarity(struct i2c_cl=
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
+	int freq_hz;
+	int duty;
+
+	if (args[1] =3D=3D 0)
+		return -EINVAL;
+
+	freq_hz =3D 1000000000UL / args[1];
+	if (args[3] >=3D args[1])
+		duty =3D 255;
+	else
+		duty =3D div_u64(255ULL * args[3], args[1]);
+
+	cfg->index =3D args[0];
+	cfg->freq =3D find_closest(freq_hz, pwmfreq_table, ARRAY_SIZE(pwmfreq_t=
able));
+	cfg->flags =3D args[2];
+	cfg->duty =3D duty;
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
@@ -1778,6 +1905,10 @@ static int adt7475_probe(struct i2c_client *client=
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


