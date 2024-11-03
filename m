Return-Path: <linux-pwm+bounces-4015-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8721A9BA794
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 20:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87AFB20C95
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC218787D;
	Sun,  3 Nov 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWv2mTIq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F665C2FB;
	Sun,  3 Nov 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660836; cv=none; b=avIJLJ0+hK1i5G8kjAYgHRMD46U8YiUCCnaE4g6M5ks4ihvRmNmpta9GvNjxwREsdAGrJIg4V4gIzLT9l/V3F+FnTG2+M/iVp/zjldexiV08YlPCjeCtletOM/2L/PWyJFlvbt5cQkFAzvqEMkpIc0mbiopIithbMA1hY5bDw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660836; c=relaxed/simple;
	bh=inPz1olU9xAQEZazepwNq7m/9CKJqGFpLVCsLGkrwHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NB9gVaz3uxKQN+Fb8JmCgyBovDwLO7r3lUZ+qsNIgu810FrHhA/Up/sSOfkQDsSacc3gX+hLCRbGsOubF9tWOX60zC2mMtyMC0FVy1j3kwnCHJoKhM1FXXBB8DT+dYn+b0a7A0l6+uPYrfPEfMfWKrpHkbsbaIvQ6LhLfm57IEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWv2mTIq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so27210295e9.2;
        Sun, 03 Nov 2024 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730660833; x=1731265633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PN4j5JM27ruL3MMdVRgYXopSApMIbDZTF6zIljuQt0=;
        b=dWv2mTIqxObqBjA3SuGLPXv5EqDiF0Xl2Qoivv4An22kAAQ8GCgqzm2AykT8spNtUo
         pXwoAMG7DBt2AstPg1fvF705yYc2nETuil+284f3s0FDcPVKUqNDutTM4Ejm+Ck80o4x
         dkXOkI7J9q1/2varKd3wdoRUiDwGTRPG+L6z8MJoei1W0jAcmE27hPavZYXHWU7UI9dd
         W/VH8ehZrrGpIRDK6NKUUXgK4nKNy3MKF4vbVZsQx/7jFPynmz4cL4ZB/cJTRfxGesOR
         wDsNj6kejP9ZNUTQnFqDKbE/q8PnoIr2kqSZLVw13+XL9wjUrMyybUQid0pUgnt9Fnnu
         XMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730660833; x=1731265633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PN4j5JM27ruL3MMdVRgYXopSApMIbDZTF6zIljuQt0=;
        b=UF+idt3sF4JKR3Fgc1V24He6GxxS8JOyr6P/keDyfYJJsKl6Lz3nXupzrh5+W9vPAb
         os6w/t9HGg3P5aUQXXRzntonvCtRUEemBg0vkpjf4+uAY3bZ5VkUfTty6uQCvNkiq+EX
         pYh4hYT/DsTDCWqN3nsxCoo0/VoLxntuNlSo1n0yAWcGOQfCNM9OBR7DzmVTihmAcVp2
         ZWpLk12qrAz12pAAqnj0fZNYmEwCBNdQbwVDJMs9z2xzbUlQlWKpDTaJH9ue9iab3Z67
         hRlZ1Q2bJ1QzIbtjp4m25hUpD3NXSHTR1SWCnUnKb0wfKOdgdOZjmAz9lbAeUS1FOJVN
         0kNw==
X-Forwarded-Encrypted: i=1; AJvYcCVcV893b+F1Jba+Hjja9iis2GB7Dh+MJuxlPdtplSjsUhAyMkZyXSBnzjjm3u2u4HUWNxQ6bpkDHnMK@vger.kernel.org, AJvYcCWiLE7cz5Vvhb4T+cqHdizJHbnLhpX0Sh/l9ojQOgAmIsNzlcki8NXWuHEEnGwIKloUnK3ew2wKkkCZ@vger.kernel.org, AJvYcCXKR7Fxtf0LKwe5loIXlGS+i4sLfxI7sgvhHNXl3n1kJUDVPv/5mHEXe6T+vBIJSjue+ThLYy2Zk0ByTmMb@vger.kernel.org
X-Gm-Message-State: AOJu0YxMW47BUJ4qrguP54V6Js44/GNQbQRoEakqBF2vOmmwNVw0c/fT
	5PUHnvAEnGiSuSjqzZvEnaOdHJZ/j10dK7ukNegV/6TR5Ujbie4F
X-Google-Smtp-Source: AGHT+IHIFoXvuCJNYxjDuvpKDd+kNXiq3JOImcMMhf+ncuSnMB/eRPWoMljK5H6pueGZiJ/0RrgylA==
X-Received: by 2002:a05:600c:5114:b0:431:60ac:9aef with SMTP id 5b1f17b1804b1-431bb9de94bmr163930405e9.29.1730660832897;
        Sun, 03 Nov 2024 11:07:12 -0800 (PST)
Received: from debian ([2a00:79c0:63e:e900:224:9bff:fe22:6dd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d685308sm129434855e9.33.2024.11.03.11.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 11:07:12 -0800 (PST)
Date: Sun, 3 Nov 2024 20:07:09 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <20241103190709.GA466098@debian>
References: <20240927125745.38367-1-dima.fedrau@gmail.com>
 <20240927125745.38367-3-dima.fedrau@gmail.com>
 <oppdnsda4tqjcpsb26j5ew62t4bkkmtxuu7e2fpinnazubk5ky@tmz76o5xdrlj>
 <20241023125221.GA197308@debian>
 <eyom32milbbqp6floun4r5bpozuewbe5kk2htvhp5cmcytj2oy@bpcrd2aiwk6m>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eyom32milbbqp6floun4r5bpozuewbe5kk2htvhp5cmcytj2oy@bpcrd2aiwk6m>

Hello Uwe,

Am Thu, Oct 24, 2024 at 11:19:16PM +0200 schrieb Uwe Kleine-König:
> Hello Dimitri,
> 
> On Wed, Oct 23, 2024 at 02:52:21PM +0200, Dimitri Fedrau wrote:
> > Am Tue, Oct 22, 2024 at 09:54:50AM +0200 schrieb Uwe Kleine-König:
> > > > +{
> > > > +	struct spi_transfer t[MC33XS2410_MAX_TRANSFERS] = { { 0 } };
> > > > +	u8 tx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> > > > +	u8 rx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
> > > > +	int i, ret, reg_i, val_i;
> > > > +
> > > > +	if (!len)
> > > > +		return 0;
> > > > +
> > > > +	if (read)
> > > > +		len++;
> > > > +
> > > > +	if (len > MC33XS2410_MAX_TRANSFERS)
> > > > +		return -EINVAL;
> > > > +
> > > > +	for (i = 0; i < len; i++) {
> > > > +		reg_i = i * MC33XS2410_WORD_LEN;
> > > > +		val_i = reg_i + 1;
> > > > +		if (read) {
> > > > +			if (i < len - 1) {
> > > > +				tx[reg_i] = reg[i];
> > > > +				tx[val_i] = ctrl[i] ? MC33XS2410_RD_CTRL : 0;
> > > > +				t[i].tx_buf = &tx[reg_i];
> > > > +			}
> > > > +
> > > > +			if (i > 0)
> > > > +				t[i].rx_buf = &rx[reg_i - MC33XS2410_WORD_LEN];
> > > > +		} else {
> > > > +			tx[reg_i] = reg[i] | MC33XS2410_WR;
> > > > +			tx[val_i] = val[i];
> > > > +			t[i].tx_buf = &tx[reg_i];
> > > > +		}
> > > > +
> > > > +		t[i].len = MC33XS2410_WORD_LEN;
> > > > +		t[i].cs_change = 1;
> > > 
> > > Not sure if MC33XS2410_WORD_LEN really improves readability here.
> > 
> > It is used throughout in the function and improves readability overall,
> > maybe not here but for consistency I would stick to it.
> 
> Seems to be subjective.
>

I will get rid of it. Due to your proposal below, to use SPI_CS_WORD, the
code to read/write from/to the device can be simplified by using a single
transaction.

> > > Why is this done using $len transfers, wouldn't a single one do (and
> > > maybe be more performant and not rely on a spi controller that supports
> > > cs_change)?
> > 
> > Without cs_change after every 16 bit, requests aren't processed by the
> > device. Reading/writing from/to device fails. The SPI controller therefore
> > must support cs_change. Single transfer is not possible because of the
> > cs_change after every 16bit.
> 
> There is SPI_CS_WORD for this usecase.
>
Thanks, didn't know about it. Helps a lot to simplify the code to
read/write from/to device. Will switch to 16 bits per word and use
SPI_CS_WORD.

> > > > +	/* polarity */
> > > > +	mask = MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm);
> > > > +	val[2] = (state->polarity == PWM_POLARITY_INVERSED) ?
> > > > +		 (val[2] | mask) : (val[2] & ~mask);
> > > > +
> > > > +	/* enable output */
> > > > +	mask = MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm);
> > > > +	val[3] = (state->enabled && rel_dc >= 0) ? (val[3] | mask) :
> > > > +						   (val[3] & ~mask);
> > > > +
> > > > +	return mc33xs2410_write_regs(spi, reg, val, 4);
> > > > +}
> > > > +
> > > > +static int mc33xs2410_pwm_get_state(struct pwm_chip *chip,
> > > > +				    struct pwm_device *pwm,
> > > > +				    struct pwm_state *state)
> > > > +{
> > > > [...]
> > > > +	state->period = mc33xs2410_pwm_get_period(val[0]);
> > > > +	state->polarity = (val[2] & MC33XS2410_PWM_CTRL1_POL_INV(pwm->hwpwm)) ?
> > > > +			  PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
> > > > +	state->enabled = !!(val[3] & MC33XS2410_PWM_CTRL3_EN(pwm->hwpwm));
> > > > +	mc33xs2410_pwm_set_relative_duty_cycle(state, val[1]);
> > > 
> > > No need to set state->duty_cycle = 0 if state->enabled is false. This is
> > > another function I suggest to unroll as it hides more than it abstracts.
> > 
> > Function can be unrolled, but the check for state->enabled is needed. The
> > device is unable to generate a 0% duty cycle, so it is turned off to
> > generate a 0% duty cylce.
> 
> What breaks if you drop the check for state->enabled?
>  
The device is unable to generate a 0% duty cycle, to support this you
proposed in an earlier review to disable the output. Without checking if
the output is disabled, the mc33xs2410_pwm_get_state function returns the
wrong duty cycle for a previously setted 0% duty cycle. A "0" value in the
MC33XS2410_PWM_DC register means that the relative duty cylce is 1/256. As
a result there are complaints if PWM_DEBUG is enabled.

Best regards,
Dimitri


