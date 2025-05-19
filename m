Return-Path: <linux-pwm+bounces-6029-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0B3ABCADB
	for <lists+linux-pwm@lfdr.de>; Tue, 20 May 2025 00:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 592651757FA
	for <lists+linux-pwm@lfdr.de>; Mon, 19 May 2025 22:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D0D21CA10;
	Mon, 19 May 2025 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJVqLA8B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78E1DE887;
	Mon, 19 May 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747693758; cv=none; b=DJIY21JqV6WUfOuTGIFfNnmoCqVW4QjL4hX7JbLw6TUKrWWadd1rIbTgxNm2VHFFvgf7ZWPGVVuFjXZlI05p5YViVIuxkLEMrdaKqm8yAcWuMK2Skuw3UizX2+P76ff8rf9PRODMp8+tIMVzGl1tXe5KZ7Ydt7Ysz5XV69w/pyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747693758; c=relaxed/simple;
	bh=vdhot2bogrAAVmaP4EuykHJI5W0v/2hfiO1ojSRA+vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggz3zpMLU7DzV8D4NFuDIfExzp8KKCY1vi0gWXpdxfp3syCX2PRrwXzgJmVi8GAtMttUmXN/F6HNXzmf2ojBu9lAUpkEvfc/AYFh8i9YsgQhasO4DX8hk1ra/kyK9pEY/aEkTbLvn5qiWhv6pqeaUZy9gPdFKrM6oiLtN68xhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJVqLA8B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2327aa24b25so2114225ad.3;
        Mon, 19 May 2025 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747693756; x=1748298556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gVfdNVHigfGlLdYVfYQUg3Ao+EVb/XXfYA5VQaT7/Mc=;
        b=RJVqLA8BFgczdE60GJj+Bp/qJ+MwAfGC/uojPWdJ3PN5Ak/DfXHillcbySxXGQhsY3
         qrPHSEunhSQrUUdEt6ClC0Phef2rXNZkBRNYPGaOSNrvemo0rqWs3I5HTg9CQvKboTbr
         2PE/33A/ZaA3BX6CSOBIF7T9iKwblzk83Nl8McHe/xtPYHKCOHseZVxjCxlWqSfvS1Fy
         ucO7dGSEHMiBTsryP86QU9Izq50ScvYnumkYnecX7By5IaGh1Y8i2X2/+03BcH+T/e82
         1lRxkJU3jiurOshRQX3rnKPTZUQCphFSQN2/vLx7PVBOm0CaYTlRTTLSl7vvo6Faszes
         /oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747693756; x=1748298556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gVfdNVHigfGlLdYVfYQUg3Ao+EVb/XXfYA5VQaT7/Mc=;
        b=uQBW2r1ft/2cPvx1h9FgkuKrwa/MIxWyX2YM6IidLY10u5ZDd73NKfJPBx+0Qm6VuX
         945ovc6hlQTWO4djpjN8yLR5Me50Je3r3sHQvEIU31axpE7twUhqd35vzAz9zPM/eqwW
         GIyHAaH44nfHR4m0xIo4HswWu7JEWzLMJH3Gtw1vrnmL25eaat1N0ozBlnVJmHF/BZgU
         DhT/aUVF8f12b4A5qqT5FHyK4wp8lJZtwkY4JcaaxTRQ0bKI15idrlAOT3veUAUFOSOS
         JJXl0YyX6X6WNbzFQiDfK2nDTUmrdyjcqtq2KPy5M3f/18WugpoE70AYgR2bFPW8EkzI
         9jow==
X-Forwarded-Encrypted: i=1; AJvYcCU30JnysQdmSTENIJ1byochIzkOM3ZMey59rmILuJiX4n3qG7GYOLV3Y2O2WyImm0dxEd/ENH30yiCV0FQ=@vger.kernel.org, AJvYcCWdsg+XlfrlRteFWXQG+fPSACpT05OSczbREMPiRpvsAwixlJ46fO909jBvBkzTB0FjHyDaNZTjzNkq@vger.kernel.org, AJvYcCXuBWVnEIRl3mQiBWGxi0jUaPFSg73CrFaEBe90JUTmcoApinaps1WpjXqQjjNLPT1K1KZGdLG/Y1e1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Jlp+WyK5VwkZxf2Vywd9AJGq9h2e6fS87+0AXWB9gKd5/DQi
	syKoWYi+ki1ZfNCk2XOEE3HdYljJkrJt3qpgFarzWURjk52uRVX6ZL7g
X-Gm-Gg: ASbGncuRiCaiM02dUwEjFCxxnvlFj+hOaP/FqtrrdtEyVMKQizjJ58uSJ2up/upndIp
	JIyklR/mDP9UNO9JBL31rXi3TQkyD8R2kgFNEBxfAgbU3gmdd4zZnvkhRZUpQA5HvmoXvRymy/m
	2U7/7lCwn42uRHSmrsXBa67KeRDZaovjBkw/jt/5tegn5i5UfKtk0eqvlajROgqTuXdOH9xr1Q8
	EAChIEOegobmMMd79WwFw3Ik1OSs8kuuK8FAkbVSKXgWpTIa+psAXSqRNfMwUg8zn23IkIeEL7s
	sy+ivZ9X4ts4vH2YIqM1BEtsarU5hT9yNAC8O2m5zbJmZ1D0Yg==
X-Google-Smtp-Source: AGHT+IExzxC1Rn8Seuzhbs42BUoT/DfFEqGl+OeWDv86sR+KOtPhL6fBwEtIP4ZkCi/7WCr7mYVlTA==
X-Received: by 2002:a17:903:19c4:b0:220:e655:d77 with SMTP id d9443c01a7336-231d452d0e3mr210299435ad.36.1747693755940;
        Mon, 19 May 2025 15:29:15 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:e134:a6aa:27:6156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97db8sm65049265ad.110.2025.05.19.15.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 15:29:15 -0700 (PDT)
Date: Mon, 19 May 2025 15:29:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 17/22] Input: adp5585: Add Analog Devices ADP5585/89
 support
Message-ID: <gdhn57zkmt5fyq33qsvdbpq3k7ofzycm24ligd3hw2cwdqkn5y@z4sk2arp6ssn>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-17-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250512-dev-adp5589-fw-v3-17-092b14b79a88@analog.com>

Hi Nuno,

On Mon, May 12, 2025 at 01:39:09PM +0100, Nuno Sá via B4 Relay wrote:
> +
> +	for (pin = 0; pin < n_pins; pin++) {
> +		if (keypad_pins[pin] >= adp5585->info->n_pins) {
> +			error = dev_err_probe(dev, -EINVAL,
> +					      "Invalid keypad pin(%u) defined\n",
> +					      keypad_pins[pin]);
> +			goto out_free_map;
> +		}
> +
> +		if (test_and_set_bit(keypad_pins[pin], adp5585->pin_usage)) {
> +			error = dev_err_probe(dev, -EBUSY,
> +					      "Keypad pin(%u) already used\n",
> +					      keypad_pins[pin]);
> +			goto out_free_map;

This jump looked confusing, together with devm, etc. I wonder, can you
move call to devm_add_action_or_reset() before the loop? It looks like
it should handle completely unpopulated pin map just fine... 

> +		}
> +
> +		__set_bit(keypad_pins[pin], &kpad->keypad);
> +	}
> +
> +	error = devm_add_action_or_reset(dev, adp5585_keys_pins_free, kpad);
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * Note that given that we get a mask (and the HW allows it), we
> +	 * can have holes in our keypad (eg: row0, row1 and row7 enabled).
> +	 * However, for the matrix parsing functions we need to pass the
> +	 * number of rows/cols as the maximum row/col used plus 1. This
> +	 * pretty much means we will also have holes in our SW keypad.
> +	 */
> +
> +	rows = find_last_bit(&kpad->keypad, kpad->info->max_rows) + 1;
> +	if (rows == kpad->info->max_rows + 1)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Now rows defined in the keypad!\n");
> +
> +	cols = find_last_bit(&kpad->keypad, kpad->info->max_cols + kpad->info->max_rows);
> +	if (cols < kpad->info->max_rows)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "No columns defined in the keypad!\n");
> +
> +	cols = cols + 1 - kpad->info->max_rows;
> +
> +	error = matrix_keypad_build_keymap(NULL, NULL, rows, cols,
> +					   kpad->keycode, kpad->input);
> +	if (error)
> +		return error;
> +
> +	kpad->row_shift = get_count_order(cols);
> +
> +	if (device_property_read_bool(kpad->dev, "autorepeat"))
> +		__set_bit(EV_REP, kpad->input->evbit);
> +
> +	return adp5585_keys_check_special_events(adp5585, kpad);

	error = adp5585_keys_check_special_events(...);
	if (error)
		return error;

	return 0;

Thanks.

-- 
Dmitry

