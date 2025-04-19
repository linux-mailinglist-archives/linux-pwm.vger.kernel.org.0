Return-Path: <linux-pwm+bounces-5579-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CEEA94116
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 04:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B94D460A50
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1B78F47;
	Sat, 19 Apr 2025 02:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6g1d2St"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D13594F;
	Sat, 19 Apr 2025 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745030698; cv=none; b=W9v3hPUri+hNOuKZ2p2EWOFKGGCSN4/4laN8SLVX9yCqjG7koatO8kshe9fDH113e3wSaqt+/0NfPCETgL2Tjo8MJIg9s1HqUKcRFVjmMnZaq+bY/BpPuoRcfkbj/xnqIYsFFtCe0Wix8o+Ayoa9l9cIRcYrsfbRn/9UDjJPglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745030698; c=relaxed/simple;
	bh=sQEzpq9sGDSgziVBQQkH/GPD70ut2wnPIuvMakEUSjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYnONXQTj/mh6ZVd3Ykc52rgBrkZodViWtoFJ1dHGGR3lBtkLQnlKqV6NMHnFw1Ux1S5gQ2uNvTg1c2l3oMo0hdF86UvwQQXXVGo5uwKt/9HhpKokzM/OfB7gkc4TLZRQXlQvt3ho+uUImNxy8Z1aKMApLxA+IhmkZe11Xy4fk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6g1d2St; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso2698081a12.2;
        Fri, 18 Apr 2025 19:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745030696; x=1745635496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqgFnrx8BBMXWFzIyUvrRovP2jhEZ8LSSxNcKE+lNjE=;
        b=B6g1d2St0odmnixQ4CuEc/KrXqavFijO0+w7sRGsgF1DE70hsujWGH2G7zXVzLRCJw
         H8DkixVwRZkDx7J8UtqQV0SkJ+yLO2H/EPYGiwUChZDbYTY4CzqaRRYySJvXXHBhjnD5
         Tvb0Ft5gqMJ1mm8lZnyEOt1JxN+nSDicTmMP9wpB0ATqDzTjcRyjMqZ0sNNxc2qEoceS
         vMkf1eXzXBXfqi6T+XD+rvoiw6qG6o0pGUdhcmEVervCdQST9bHmXCWd0vtyIjEvZeKH
         7HbqC9rzU5zU3195Xgs2KGfuR6cRWV9HdQPYIbHfaMJt2M+E+6I4HmREouaOaejIEKn1
         Kvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745030696; x=1745635496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqgFnrx8BBMXWFzIyUvrRovP2jhEZ8LSSxNcKE+lNjE=;
        b=qnGJbOQ54Wg3c2k5pEqOQY/IaKfiSujSBDRGdhG7uHzUvvsvFFI4wKeWKpZCyGdJn3
         U8E00P/uatPwvLuZYfrpb4rm1Zm7cxJdv0TKnylaizDto+Vecvvx5pcJPuk0p7+2b1Rr
         S5RF6amtH3q3NyJKzx714T4/UGWF5neOBWe8jbjo05h7d4VWQnAk+nJChUEyFKWIFHRw
         YuM31FWKLKzh4BPh7WQpJT+lefPRqMTQ0Cg9APb8c9vydF+CXSVhVHeRlmQcQanrt3ec
         +Y9WC6u8/ZEc5DRW2mQ9WfxwltvT6I7N1vpNv3Jyg+uE3yNXwrE4lthMKZhzKXaz9bye
         iWMg==
X-Forwarded-Encrypted: i=1; AJvYcCUpezutJB/sh9fxyfRdXQG4/3rLF2KGbXd5aw270zWi430gpsF+oiNkD5Lvw8EFsqT0/+08PTSRcxyg@vger.kernel.org, AJvYcCW806hIcgaZaM/n5HpHkAf4sCU6YcRMJiJo3UJOOw06iJfLY2xLnz+8wDSX22oVnak/mOGT+QnZg5/5FGI=@vger.kernel.org, AJvYcCXqqRuKLevdsI02+NzuMyKyW0++krJ5PfszhidmQ6gKit3bWwC+F4KnysVL12Tp6g5cv+CIiL6U7H5u@vger.kernel.org
X-Gm-Message-State: AOJu0YyarXqDB2IDGF47NmkYh8ajHePcpNnR+a3HfQZ0j6M49TwHzEyy
	yObmuMPAy01MBuLwepVuPlkbyCg5t6/yR99ft+OX2S6PiDXeDd8c
X-Gm-Gg: ASbGncsldAfQjP8q64ZU7t7QIctV0cDSwT+17/LSdMp/oo91mcOHhbeklmTLv9ILFY9
	+annrtXCz6Kn28VBh7rcEHrwfKGA5CNvBy1Fn+uDfblgmPnnwbuTISYCuC/0zj5f3Hu41o0o98n
	gnJaH6ZaSvVHJCs/hSSsLlcHAdYPt1x3hHfPKD0aw06fnuhpRjzLGjQF4tmNmn5aMlIdtUCmqwr
	9PepPT4saKxYBX1y2UdiidzAiAENb0dnXLcwM3qJwOq0hYyZCStBbxOQGErDJJzyci0+o2AwS2r
	USa8enuxsl1Oh3IE/yPmvU4PzZj5MC56uNQFoFu/EC8S3dzY6/HB
X-Google-Smtp-Source: AGHT+IGl8ov5ezlYRG4ldec2lzDStegkYiKtw2ROtgkP2CwlTjT33MqqeCaZWuKa+LOa/TsBYK5CSA==
X-Received: by 2002:a05:6a21:2d05:b0:201:b65:81ab with SMTP id adf61e73a8af0-203cbc698c7mr6270114637.23.1745030696022;
        Fri, 18 Apr 2025 19:44:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:eaea:89f0:c84d:941a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8c0200sm2317871b3a.1.2025.04.18.19.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 19:44:55 -0700 (PDT)
Date: Fri, 18 Apr 2025 19:44:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 12/17] Input: adp5585: Add Analog Devices ADP5585/89
 support
Message-ID: <4v2ohz5zuyijwxunm2zfr4xhj55ny6leytgsym43rzx5qwqc7g@2igv7sx22y3m>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-12-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-12-3a799c3ed812@analog.com>

Hi Nuno,

On Tue, Apr 15, 2025 at 03:49:28PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the keyboard function using the platform device
> registered by the core MFD driver.
> 
> The ADP5589 has 19 pins and also features an unlock function.

This looks mostly good, just a few nits.

> +
> +static int adp5585_keys_parse_fw(const struct adp5585_dev *adp5585,
> +				 struct adp5585_kpad *kpad)
> +{
> +	unsigned long row_map, col_map;
> +	struct device *dev = kpad->dev;
> +	u32 cols = 0, rows = 0;
> +	int ret;

Please name variables holding error code or 0 "error".

> +
> +	row_map = bitmap_read(adp5585->keypad, 0, kpad->max_rows);
> +	col_map = bitmap_read(adp5585->keypad, kpad->max_rows, kpad->max_cols);
> +	/*
> +	 * Note that given that we get a mask (and the HW allows it), we
> +	 * can have holes in our keypad (eg: row0, row1 and row7 enabled).
> +	 * However, for the matrix parsing functions we need to pass the
> +	 * number of rows/cols as the maximum row/col used plus 1. This
> +	 * pretty much means we will also have holes in our SW keypad.
> +	 */
> +	if (!bitmap_empty(&row_map, kpad->max_rows))
> +		rows = find_last_bit(&row_map, kpad->max_rows) + 1;
> +	if (!bitmap_empty(&col_map, kpad->max_cols))
> +		cols = find_last_bit(&col_map, kpad->max_cols) + 1;
> +
> +	if (!rows && !cols)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "No rows or columns defined for the keypad\n");
> +
> +	if (cols && !rows)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Cannot have columns with no rows!\n");
> +
> +	if (rows && !cols)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Cannot have rows with no columns!\n");
> +
> +	ret = matrix_keypad_build_keymap(NULL, NULL, rows, cols,
> +					 kpad->keycode, kpad->input);
> +	if (ret)
> +		return ret;
> +
> +	kpad->row_shift = get_count_order(cols);
> +
> +	if (device_property_present(kpad->dev, "autorepeat"))

"autorepeat" is essentially a boolean property, so please use
device_property_read_bool() here.

> +		__set_bit(EV_REP, kpad->input->evbit);
> +
> +	return 0;
> +}
> +
> +static int adp5585_keys_setup(const struct adp5585_dev *adp5585,
> +			      struct adp5585_kpad *kpad)
> +{
> +	unsigned long keys_bits, start = 0, nbits = kpad->max_rows;
> +	const struct adp5585_regs *regs = adp5585->info->regs;
> +	unsigned int i = 0, max_cols = kpad->max_cols;
> +	int ret;

	int error;

> +
> +	/*
> +	 * Take care as the below assumes max_rows is always less or equal than
> +	 * 8 which is true for the supported devices. If we happen to add
> +	 * another device we need to make sure this still holds true. Although
> +	 * adding a new device is very unlikely.
> +	 */
> +	do {
> +		keys_bits = bitmap_read(adp5585->keypad, start, nbits);
> +		if (keys_bits) {
> +			ret = regmap_write(adp5585->regmap, regs->pin_cfg_a + i,
> +					   keys_bits);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		start += nbits;
> +		if (max_cols > 8) {
> +			nbits = 8;
> +			max_cols -= nbits;
> +		} else {
> +			nbits = max_cols;
> +		}
> +
> +		i++;
> +	} while (start < kpad->max_rows + kpad->max_cols);
> +
> +	return 0;
> +}
> +
> +static void adp5585_keys_ev_handle(struct device *dev, unsigned int key,
> +				   bool key_press)
> +{
> +	struct adp5585_kpad *kpad = dev_get_drvdata(dev);
> +	unsigned int row, col, code;
> +

Please check that key is not 0 to avoid OOB access. While the device is
unlikely to ever send 0 cosmic rays may happen. And I guess we should
check the max as well.

> +	row = (key - 1) / (kpad->max_cols);
> +	col = (key - 1) % (kpad->max_cols);
> +	code = MATRIX_SCAN_CODE(row, col, kpad->row_shift);
> +
> +	dev_dbg_ratelimited(kpad->dev, "report key(%d) r(%d) c(%d) code(%d)\n",
> +			    key, row, col, kpad->keycode[code]);
> +
> +	input_report_key(kpad->input, kpad->keycode[code], key_press);
> +	input_sync(kpad->input);
> +}
> +
> +static void adp5585_keys_ev_handle_clean(void *adp5585)
> +{
> +	adp5585_keys_ev_handle_set(adp5585, NULL, NULL);
> +}
> +
> +static int adp5585_keys_probe(struct platform_device *pdev)
> +{
> +	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct adp5585_kpad *kpad;
> +	unsigned int revid;
> +	const char *phys;
> +	int ret;

	int error;

> +
> +	kpad = devm_kzalloc(dev, sizeof(*kpad), GFP_KERNEL);
> +	if (!kpad)
> +		return -ENOMEM;
> +
> +	if (!adp5585->irq)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "IRQ is mandatory for the keypad\n");
> +
> +	kpad->dev = dev;
> +	kpad->max_cols = adp5585->info->max_cols;
> +	kpad->max_rows = adp5585->info->max_rows;
> +
> +	kpad->input = devm_input_allocate_device(dev);
> +	if (!kpad->input)
> +		return -ENOMEM;
> +
> +	ret = regmap_read(adp5585->regmap, ADP5585_ID, &revid);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read device ID\n");
> +
> +	phys = devm_kasprintf(dev, GFP_KERNEL, "%s/input0", pdev->name);
> +	if (!phys)
> +		return -ENOMEM;
> +
> +	kpad->input->name = pdev->name;
> +	kpad->input->phys = phys;
> +	kpad->input->dev.parent = dev;

No need to set parent because devm_input_allocate_device() does it for
you.

> +
> +	input_set_drvdata(kpad->input, kpad);

I do not see input_get_drvdata() anywhere, so maybe remove this call?

> +
> +	kpad->input->id.bustype = BUS_I2C;
> +	kpad->input->id.vendor = 0x0001;
> +	kpad->input->id.product = 0x0001;
> +	kpad->input->id.version = revid & ADP5585_REV_ID_MASK;
> +
> +	device_set_of_node_from_dev(dev, dev->parent);
> +
> +	ret = adp5585_keys_parse_fw(adp5585, kpad);
> +	if (ret)
> +		return ret;
> +
> +	ret = adp5585_keys_setup(adp5585, kpad);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, kpad);
> +	adp5585_keys_ev_handle_set(adp5585, adp5585_keys_ev_handle, dev);
> +	ret = devm_add_action_or_reset(dev, adp5585_keys_ev_handle_clean,
> +				       adp5585);
> +	if (ret)
> +		return ret;
> +
> +	return input_register_device(kpad->input);

	error = input_register_device(...);
	if (error)
		dev_err_probe(...);

	return 0;

> +}
> +
> +static const struct platform_device_id adp5585_keys_id_table[] = {
> +	{ "adp5585-keys" },
> +	{ "adp5589-keys" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, adp5585_keys_id_table);
> +
> +static struct platform_driver adp5585_keys_driver = {
> +	.driver	= {
> +		.name = "adp5585-keys",
> +	},
> +	.probe = adp5585_keys_probe,
> +	.id_table = adp5585_keys_id_table,
> +};
> +module_platform_driver(adp5585_keys_driver);
> +
> +MODULE_AUTHOR("Nuno Sá <nuno.sa@analog.com>");
> +MODULE_DESCRIPTION("ADP5585 Keys Driver");
> +MODULE_LICENSE("GPL");

Thanks.

-- 
Dmitry

