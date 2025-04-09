Return-Path: <linux-pwm+bounces-5430-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED208A82F15
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 20:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14694A2247
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 18:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FE1278145;
	Wed,  9 Apr 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwSLT6GO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FF2278141;
	Wed,  9 Apr 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224053; cv=none; b=fifHNuWBqOIZzVMf2St9Xr6fUCpy+3QVGF+HY4WzWi6TPptKgpUCggNYbxjtbzxVyzwQiED/RBa/1w4j+U0LJpDANiqSKBmcQA1ZWF2dWJtMR1bDBd6HKspqHiC/dTo89iXfMaI2P81YSf3+7iVKhdJETrKhnIaUOZAbVvQE68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224053; c=relaxed/simple;
	bh=7ce31LOaktiwPuRBBPpSmmXKf6M/YMvZPR0T7UZBGh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK706aEs7/OOFr6ZcF12JgDmMUxq/UksY/fRos6Ou+Reg5uXNk2S9WCBA0M3257NLibar7qcL8cWtvHLqO1NCZcc5wt4wlH7xoZfOkTVeIBDxFPOwxACmGkYY9IQTyTa40d888T+/fokAp0fA90kUYRMBJIV1ADzH0PKvir1qZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwSLT6GO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227d6b530d8so66216775ad.3;
        Wed, 09 Apr 2025 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744224051; x=1744828851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XKCylbKIjrgOfv1bOhlYLqzn746P08J59uI4yN7YCeY=;
        b=NwSLT6GOJL7nuSu3848e0KNpM6ULT4lyMxJJYKoC0tXT6nJDPVQjUQCLxKz4lQg8cg
         p4rjqv3/D5xHAeLWCwSn3KZ9TQyEYoxefYenYLi4Ff9n78ybSzKmwdtlJHLMAwPC48Im
         f9uKVDBLz+h1w4JVnYodda/JdKzgAmbrE5YCsg5HAEOKnC9TuUSkUjxGz5hQNWcqIYsd
         y58L1o2zWwSgqIrnG4en8I1dWrTGSgOCnLIE7ZwIkz/go3LcZ5sFpV5p25yS5XdvZwUN
         pJg7RPWbSyI4JI0lD4xBEmy+F7UKp2IA4ls0tkN/VwQOaVgtE2YyE3DeWz/9ayqPJA9E
         /8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224051; x=1744828851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKCylbKIjrgOfv1bOhlYLqzn746P08J59uI4yN7YCeY=;
        b=NxNRTBz2f8PgtNq07rSPZriIaj1/UBLBTeCfkXoV4+Ki4L2/L5sWdaOeoO2ujroal/
         NYwwN2f3KU/52osyY4JxoJEpZbi75BAtIPhfvfrdNKhuhTU2BsT9e32bFuekY4usJQQ5
         Z+QR6lE0zBevT6SzntYozhCbZYaS/3lZR44F9yipgQFZ7tgYr3DbOjFFZXEfgHEuBGXJ
         SN+dGu65jJo2axERhT2BODrncT+uhifeuxP8STcaybhsX6KTa6BYHMni8IY+ZFY5WGrq
         6Ap4gVpnIY5BgCRCOOThkBAnAnTRBofFRKraJI0tYyJ2qwMX70IpN5biZy9MKAGH5vfJ
         VEZw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Jh0JJ8+kBUMUgXx6gBB0X2iNSea1llHwosn9nGxa1tP3x+R7xi+K7eQXgnwA8D6ZAUY1Vlk2QS7Y@vger.kernel.org, AJvYcCUOWMIZPIzXHm60oduypPUykmviYSqUGPPlcIOq1Xw7POj/uq34gTxh9UrO8Yk6dfSOZQgoWXHT/OJHtw==@vger.kernel.org, AJvYcCUpTUPz5DtyJC/Dg3xYyblBIzFTt0wI8iSHwl/Y27EgH1ytXTkm6yeGiHluXJIHl2EMajxMpfMqbyuuKbMg@vger.kernel.org, AJvYcCVnuH74Tg8YQvhOlM5vnyJJmr/M4XO+tZxKly/TU5RGG9dEL3QVREUd/AZkLz2ahiucuLVPukJ+ZdiQc8w=@vger.kernel.org, AJvYcCWXbjZiKCyeCtue4ESjl3YQjChFvbc/mL7tI2ri7FJC/aFK3EpCf611BgxHNVXmtCw5d8qoe41KLNAs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0DuhSWIzYtZ1TL41KhkYFfyG8WKF60mDgaWa94G2oqswgu5hl
	CT9ZV793LclvNMzAx2Re/ugGZbbgeetiJCdQi2aKjE7X3Hx8e+Pk
X-Gm-Gg: ASbGncvMNLkRbtCsvuvoxk133Tg612aHDxOiqCGN9fxX76HbJk4L+CCgzKXUMKlTRYL
	t+7yqs8EnWlDNzCdtf+FU1zFT20vJ7IVS4OS709uzJlfaF6PPqmBqclCdHHlEexADrvVKtNfNn1
	HS6F8N2qWycQtu+M2ZscgwzW2a/hsGTDdjoY8jFjcQg0naOam1siaO/fBXd3SQZ8lKUCt7hkc5f
	wNeD4KzGEVh+GjUzRjeDJbBrb/RWB+ON+UckWVqg0iDT+NECN+SpUNF1PESiyaODpomuohJDWBk
	S3vn3BZMrn6wnl8UP6ZaW9wEdpbL7IhORIy8wx/C1Q==
X-Google-Smtp-Source: AGHT+IEvVcXJt7NNKX5SaeEVlcZaK6qMDnh8XmZ4fCAiKyzsL52qof/mXos31CnmY0ZKrW4CD72UiA==
X-Received: by 2002:a17:902:d2ca:b0:224:1c41:a4cd with SMTP id d9443c01a7336-22ac296e7d5mr49925255ad.3.1744224051208;
        Wed, 09 Apr 2025 11:40:51 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cff4:8871:54bb:4c97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb5c5sm15464235ad.222.2025.04.09.11.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:40:50 -0700 (PDT)
Date: Wed, 9 Apr 2025 11:40:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 10/12] input: keyboard: Add support for MAX7360 keypad
Message-ID: <chhnkepvlbiv6xvgh5zso526xsp4zk7tgzsqzoqe7b5jmvdyrw@afio6lmx55zv>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-10-7a2535876e39@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-mdb-max7360-support-v6-10-7a2535876e39@bootlin.com>

Hi Mathieu,

On Wed, Apr 09, 2025 at 04:55:57PM +0200, Mathieu Dubois-Briand wrote:
> +struct max7360_keypad {
> +	struct input_dev *input;
> +	unsigned int rows;
> +	unsigned int cols;
> +	unsigned int debounce_ms;
> +	int irq;
> +	struct regmap *regmap;
> +	unsigned short keycodes[MAX7360_MAX_KEY_ROWS * MAX7360_MAX_KEY_COLS];
> +};
> +
> +static irqreturn_t max7360_keypad_irq(int irq, void *data)
> +{
> +	struct max7360_keypad *max7360_keypad = data;
> +	unsigned int val;
> +	unsigned int row, col;
> +	unsigned int release;
> +	unsigned int code;
> +	int ret;

int error;

> +
> +	do {
> +		ret = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
> +		if (ret) {
> +			dev_err(&max7360_keypad->input->dev, "Failed to read max7360 FIFO");

This will return name pf the input device, whereas logging name of the
platform device (representing the hardware device) would be much more
interesting. You can either use max7360_keypad->input->dev.parent, or,
better yet, add *dev pointer to struct max7360_keypad.

> +			return IRQ_NONE;
> +		}
> +
> +		/* FIFO overflow: ignore it and get next event. */
> +		if (val == MAX7360_FIFO_OVERFLOW)
> +			dev_warn(&max7360_keypad->input->dev, "max7360 FIFO overflow");
> +	} while (val == MAX7360_FIFO_OVERFLOW);
> +
> +	if (val == MAX7360_FIFO_EMPTY) {
> +		dev_dbg(&max7360_keypad->input->dev, "Got a spurious interrupt");
> +
> +		return IRQ_NONE;
> +	}
> +
> +	row = FIELD_GET(MAX7360_FIFO_ROW, val);
> +	col = FIELD_GET(MAX7360_FIFO_COL, val);
> +	release = val & MAX7360_FIFO_RELEASE;
> +
> +	code = MATRIX_SCAN_CODE(row, col, MAX7360_ROW_SHIFT);
> +
> +	dev_dbg(&max7360_keypad->input->dev, "key[%d:%d] %s\n", row, col,
> +		release ? "release" : "press");
> +
> +	input_event(max7360_keypad->input, EV_MSC, MSC_SCAN, code);
> +	input_report_key(max7360_keypad->input, max7360_keypad->keycodes[code], !release);
> +	input_sync(max7360_keypad->input);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int max7360_keypad_open(struct input_dev *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
> +	int ret;

"int error" for variables holding error codes or 0. Also elsewhere in
the driver.

> +
> +	/* Somebody is using the device: get out of sleep. */
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
> +				MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
> +	if (ret)
> +		dev_err(&max7360_keypad->input->dev, "Failed to write max7360 configuration\n");

Log error code?

Explicit error return please.
		retrun error;
	}
> +
> +	return ret;

	return 0;

> +}
> +
> +static void max7360_keypad_close(struct input_dev *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
> +	int ret;
> +
> +	/* Nobody is using the device anymore: go to sleep. */
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG, MAX7360_CFG_SLEEP, 0);
> +	if (ret)
> +		dev_err(&max7360_keypad->input->dev,
> +			"Failed to write max7360 configuration\n");

Log error code?

> +}
> +
> +static int max7360_keypad_hw_init(struct max7360_keypad *max7360_keypad)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	val = max7360_keypad->debounce_ms - MAX7360_DEBOUNCE_MIN;
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_DEBOUNCE,
> +				MAX7360_DEBOUNCE,
> +				FIELD_PREP(MAX7360_DEBOUNCE, val));
> +	if (ret) {
> +		return dev_err_probe(&max7360_keypad->input->dev, ret,
> +			"Failed to write max7360 debounce configuration\n");
> +	}

No need for braces with single line statements.

> +
> +	ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_INTERRUPT,
> +				MAX7360_INTERRUPT_TIME_MASK,
> +				FIELD_PREP(MAX7360_INTERRUPT_TIME_MASK, 1));
> +	if (ret) {
> +		return dev_err_probe(&max7360_keypad->input->dev, ret,
> +			"Failed to write max7360 keypad interrupt configuration\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int max7360_keypad_build_keymap(struct max7360_keypad *max7360_keypad)
> +{
> +	struct input_dev *input_dev = max7360_keypad->input;
> +	struct device *dev = input_dev->dev.parent->parent;
> +	struct matrix_keymap_data keymap_data;
> +	const char *propname = "linux,keymap";
> +	unsigned int max_keys;
> +	int size;
> +	int ret;
> +
> +	size = device_property_count_u32(dev, propname);
> +	if (size <= 0) {
> +		dev_err(dev, "missing or malformed property %s: %d\n", propname, size);
> +		return size < 0 ? size : -EINVAL;
> +	}
> +
> +	max_keys = max7360_keypad->cols * max7360_keypad->rows;
> +	if (size > max_keys) {
> +		dev_err(dev, "%s size overflow (%d vs max %u)\n", propname, size, max_keys);
> +		return -EINVAL;
> +	}
> +
> +	u32 *keys __free(kfree) = kmalloc_array(size, sizeof(*keys), GFP_KERNEL);
> +	if (!keys)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_u32_array(dev, propname, keys, size);
> +	if (ret) {
> +		dev_err(dev, "failed to read %s property: %d\n", propname, ret);
> +		return ret;
> +	}
> +
> +	keymap_data.keymap = keys;
> +	keymap_data.keymap_size = size;
> +	ret = matrix_keypad_build_keymap(&keymap_data, NULL, max7360_keypad->rows, max7360_keypad->cols,
> +					 max7360_keypad->keycodes, max7360_keypad->input);

What if it fails? Error handling please.

Also, it looks like you are repeating what matrix_keypad_build_keymap()
is already doing. If you pass NULL as keymap data, won't it do the right
thing?

> +
> +	return 0;
> +}
> +
> +static int max7360_keypad_parse_fw(struct device *dev,
> +				   struct max7360_keypad *max7360_keypad,
> +				   bool *autorepeat)
> +{
> +	int ret;
> +
> +	ret = matrix_keypad_parse_properties(dev->parent, &max7360_keypad->rows,
> +					     &max7360_keypad->cols);
> +	if (ret)
> +		return ret;
> +
> +	if (!max7360_keypad->rows || !max7360_keypad->cols ||
> +	    max7360_keypad->rows > MAX7360_MAX_KEY_ROWS ||
> +	    max7360_keypad->cols > MAX7360_MAX_KEY_COLS) {
> +		dev_err(dev, "Invalid number of columns or rows (%ux%u)\n",
> +			max7360_keypad->cols, max7360_keypad->rows);
> +		return -EINVAL;
> +	}
> +
> +	*autorepeat = device_property_read_bool(dev->parent, "autorepeat");
> +
> +	max7360_keypad->debounce_ms = MAX7360_DEBOUNCE_MIN;
> +	ret = device_property_read_u32(dev->parent, "keypad-debounce-delay-ms",
> +				       &max7360_keypad->debounce_ms);
> +	if (ret == -EINVAL) {
> +		dev_info(dev, "Using default keypad-debounce-delay-ms: %u\n",
> +			 max7360_keypad->debounce_ms);
> +	} else if (ret < 0) {
> +		dev_err(dev, "Failed to read keypad-debounce-delay-ms property\n");
> +		return ret;
> +	}
> +
> +	if (!in_range(max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN,
> +		      MAX7360_DEBOUNCE_MAX - MAX7360_DEBOUNCE_MIN)) {
> +		dev_err(dev, "Invalid keypad-debounce-delay-ms: %u, should be between %u and %u.\n",
> +			max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN, MAX7360_DEBOUNCE_MAX);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max7360_keypad_probe(struct platform_device *pdev)
> +{
> +	struct max7360_keypad *max7360_keypad;
> +	struct device *dev = &pdev->dev;
> +	struct input_dev *input;
> +	struct regmap *regmap;
> +	bool autorepeat;
> +	int ret;
> +	int irq;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");

		return dev_err_probe(...) ?

Thanks.

-- 
Dmitry

