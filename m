Return-Path: <linux-pwm+bounces-6032-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D19ABE2BA
	for <lists+linux-pwm@lfdr.de>; Tue, 20 May 2025 20:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1AF3A4349
	for <lists+linux-pwm@lfdr.de>; Tue, 20 May 2025 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54DD276041;
	Tue, 20 May 2025 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiVGH5dM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD381BD9F0;
	Tue, 20 May 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766040; cv=none; b=m5gRwyKwnLunejdUamviTVahxJg4qzF2C+pmUmUnCQi+X8stIcAaPX+vZadmOL/pd7bKcvP6Ld1zHCBnrVfQzwdox5FEw2smq5+QNxl/V9ezHETP/9++VUdxXOz/viaxmWsjgQ+XFUVMahBhEs534pfk9eWYTq3rCEy9ujdKAb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766040; c=relaxed/simple;
	bh=lWVC38L8uqB00AbYWjtpZKYvJmwx1+KZHM9F+v/8Boo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESVy2D6p0LISZkVAAcn8BduCaLgZrkB9MiOy6tiQDjNJWReVsLaTIdh5BQFjWH09c+dFvuoP+nciZZbGR5Dh5zoKMEscrBexTYsXqSmJd5I3mUKyr6aOrkO5WEZcAlSVPXG4ReNsGQESgHkCY/x/DvLsl7uZPK4F+zH2V1IxRDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HiVGH5dM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30e5430ed0bso5877832a91.3;
        Tue, 20 May 2025 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747766038; x=1748370838; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GnYX8VZ84uwroHmlgsQbS7s/JHKMgvRRy4+aknrxe4M=;
        b=HiVGH5dMkVT6ycy3Sjvn3ThOFZaY1wza09wqLCZmZJhw9Lud1zvNXupJU1oKNXOYwl
         qifEvHtRSdFigvWtixZwm1K5HP+DJHXL5sVk60BuVfw+NmnLe6xTKQO6gUB8G2lcfMBn
         kPQxENGjjqtYv5HQcxiLdKU9aGXPDRgREmnMqc0gk8YjtUGpbrTsk4HToZB+SmkUufR+
         SPtxSoHAg/fVLFI6P4QxTSLaKMN2/fS7eHWF8wn2HtGS8GLP5x7snVHy0KjWio5iXPcE
         MQEVTz1Z8ovZ40axt18GW1w8Irqkr5WWGYa1O9ArZ1eyVauTo7t2wPB32ULuBQ7zZIb7
         UE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747766038; x=1748370838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnYX8VZ84uwroHmlgsQbS7s/JHKMgvRRy4+aknrxe4M=;
        b=oDLAC4mAnM1cd36v8CzjLXyVC6jOovXjw2UF8qvxmkCCq/DecsqfHk291Sckz9dAKd
         r1gClajRRbtQpgdBY8w4ulyFoLzOrtijlBaDy/oGN/wXkXUFmy7qBVsrjSIt7r4B59p0
         pHcHhiuXoTgPfwvx2mVYPSxq86/cWj5MFygcZQAQl/mYqSNIdJnvTYPCwPGTyG35ikyN
         q7c8QnRRJRAIJ+q089HSYfRAQFruHwx9UzYemPaH0VEWTKkUxDUNxc4CpuaKrVPEuKUH
         FA2ycw74eWC55qTaZuty6xa1bhs9t+q7Qh+VorR34ehL+jRyD4TygilcA9UYK/87Bzy0
         4AJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD4WWEU+zgtOdIlPmWPjVx/6dia9E0yuXL722x5bPfScDT3WhWEohayqHAQ63kJao7MPexLEAjBninY+Y=@vger.kernel.org, AJvYcCVAhmyJ6xmsvRGeNr0UrHyrurRGWLi/BhyIEdC+lq/wmggpcyYf1qY9zDg6jsE3EiS8YHImPoriewj2@vger.kernel.org, AJvYcCVAjwuA3Yhh3EFq79HPsDSz/xshBTme8CLBqtAnWpxP56gUC9rOESvZWJji6mrRWZYX69RQB026kVn9Kg==@vger.kernel.org, AJvYcCWwk4Djrhx1Ind7qurYzqUpN8asQtFJPwGpltSnwF3kSR4UbdS0tBKNzlIBKk1TBkoWzfy0kE7WQcbw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bOjBINXM/fHwYa/TeTmJfYVVCTlNOzLgmSmWezoEKIPTbt4n
	OKfPqR8Sh8qUmoxOXzaPGPU4NFrp1B0QJoGwcjCb6aYbKPaT1YumZSlk
X-Gm-Gg: ASbGncu1DXX9fql67xTIPEiIxvXf5weu849WQbnRvSwa5rqJ23rkFpSuIZpzcHNxpvO
	uo2mvJ/Lv+BnansaK+2VHIFPxYgFU+M+lCCk8hTaRlR9j/NHrGbDGZPhTIBCTa6e0Q9bZmDiyV1
	Cqgmxux/SRoO/tEFC7Uu8cz1Gb48ddHqjFSedMrKIYdwAVB9uUMCepaowppPWKd0fpUvYAtB4J4
	UthyJjQbjbm/XJSS4k3Bm9AoAJV/1O5eANpH8H6lCV9A81nFCszbbxUnwBdt7+h9tOKxUVUsoh0
	Po2WGp8rpLiilKYTFoNBu0+6qnwr7j6wXSUAoGMamXnizJMSik8ChUfeqN/0B1E=
X-Google-Smtp-Source: AGHT+IFoYlmtpsWdgvMPxvGs7eJfyjWqsqw9gnGUp40hjYN1Kr5Ldm4oK/sCXthGMZ1ofVfV6QaO1g==
X-Received: by 2002:a17:90b:2b45:b0:2ff:52e1:c49f with SMTP id 98e67ed59e1d1-30e8322595fmr23855447a91.26.1747766038141;
        Tue, 20 May 2025 11:33:58 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:533f:75df:b89f:cab5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f364907dfsm2051710a91.23.2025.05.20.11.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 11:33:57 -0700 (PDT)
Date: Tue, 20 May 2025 11:33:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v3 17/22] Input: adp5585: Add Analog Devices ADP5585/89
 support
Message-ID: <j2zueeyfq2mkr56b5pauektzqwfmo4ob32fcb7r5oavwdunsab@6knd5a6raaef>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
 <20250512-dev-adp5589-fw-v3-17-092b14b79a88@analog.com>
 <gdhn57zkmt5fyq33qsvdbpq3k7ofzycm24ligd3hw2cwdqkn5y@z4sk2arp6ssn>
 <0b17ac3e9de55715fe1cd5f836a87664ae6161dd.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b17ac3e9de55715fe1cd5f836a87664ae6161dd.camel@gmail.com>

On Tue, May 20, 2025 at 09:32:53AM +0100, Nuno Sá wrote:
> On Mon, 2025-05-19 at 15:29 -0700, Dmitry Torokhov wrote:
> > Hi Nuno,
> > 
> > On Mon, May 12, 2025 at 01:39:09PM +0100, Nuno Sá via B4 Relay wrote:
> > > +
> > > +	for (pin = 0; pin < n_pins; pin++) {
> > > +		if (keypad_pins[pin] >= adp5585->info->n_pins) {
> > > +			error = dev_err_probe(dev, -EINVAL,
> > > +					      "Invalid keypad pin(%u)
> > > defined\n",
> > > +					      keypad_pins[pin]);
> > > +			goto out_free_map;
> > > +		}
> > > +
> > > +		if (test_and_set_bit(keypad_pins[pin], adp5585->pin_usage))
> > > {
> > > +			error = dev_err_probe(dev, -EBUSY,
> > > +					      "Keypad pin(%u) already
> > > used\n",
> > > +					      keypad_pins[pin]);
> > > +			goto out_free_map;
> > 
> > This jump looked confusing, together with devm, etc. I wonder, can you
> > move call to devm_add_action_or_reset() before the loop? It looks like
> > it should handle completely unpopulated pin map just fine... 
> 
> Seemed the logical way but I agree that what you suggest makes it more simpler.
> 
> > 
> > > +		}
> > > +
> > > +		__set_bit(keypad_pins[pin], &kpad->keypad);
> > > +	}
> > > +
> > > +	error = devm_add_action_or_reset(dev, adp5585_keys_pins_free,
> > > kpad);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	/*
> > > +	 * Note that given that we get a mask (and the HW allows it), we
> > > +	 * can have holes in our keypad (eg: row0, row1 and row7 enabled).
> > > +	 * However, for the matrix parsing functions we need to pass the
> > > +	 * number of rows/cols as the maximum row/col used plus 1. This
> > > +	 * pretty much means we will also have holes in our SW keypad.
> > > +	 */
> > > +
> > > +	rows = find_last_bit(&kpad->keypad, kpad->info->max_rows) + 1;
> > > +	if (rows == kpad->info->max_rows + 1)
> > > +		return dev_err_probe(dev, -EINVAL,
> > > +				     "Now rows defined in the keypad!\n");
> > > +
> > > +	cols = find_last_bit(&kpad->keypad, kpad->info->max_cols + kpad-
> > > >info->max_rows);
> > > +	if (cols < kpad->info->max_rows)
> > > +		return dev_err_probe(dev, -EINVAL,
> > > +				     "No columns defined in the
> > > keypad!\n");
> > > +
> > > +	cols = cols + 1 - kpad->info->max_rows;
> > > +
> > > +	error = matrix_keypad_build_keymap(NULL, NULL, rows, cols,
> > > +					   kpad->keycode, kpad->input);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	kpad->row_shift = get_count_order(cols);
> > > +
> > > +	if (device_property_read_bool(kpad->dev, "autorepeat"))
> > > +		__set_bit(EV_REP, kpad->input->evbit);
> > > +
> > > +	return adp5585_keys_check_special_events(adp5585, kpad);
> > 
> > 	error = adp5585_keys_check_special_events(...);
> > 	if (error)
> > 		return error;
> 
> Curious, any special reason for the above? Or is just personal preference?

More of a personal preference, however there is some logic to it ;) - 
in a function with multiple failure/return points such form allows for
easy addition and/or movement of the code.

Thanks.

-- 
Dmitry

