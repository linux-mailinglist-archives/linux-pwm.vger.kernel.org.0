Return-Path: <linux-pwm+bounces-1201-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C741849122
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 23:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8F1F21785
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Feb 2024 22:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2EF567D;
	Sun,  4 Feb 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URzBlsfz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A8B676
	for <linux-pwm@vger.kernel.org>; Sun,  4 Feb 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707087028; cv=none; b=Y7SQD7xd6uwQTC5xFaJYtx1iGkkn0zKzscK9gZ0HNOpgO5EbAyX7QKrJnvJk3XYqexLXpQSd6+ejQSSe1bXCk5/ju71Ospy7qNEFUF92GTOLw+5BmfibJy1DrPV6wsRST64FCY8OJWpOGECOrLyMJHCNcxVU5ceEnns/dkyHwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707087028; c=relaxed/simple;
	bh=LJGslSdmd1vgdLi8XbXgKYfizKVevhSbT6nn84foCCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/K+T/DwG7p1sjSy8bpZ0ODBw8bkz/PwSYInu7YSBsElT426y5mAY+hXqexenJGu6Mb01OZFsW8D87/HUbQKuEyhqTV/JReFQeAG2Sr1n+e1TcbVpV4XfWUJ3j3JMV9pDTx/claFBsiGx6KnxqqJ2SEOhqh5YtLRQsy6kEEl6tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URzBlsfz; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-598699c0f1eso2745462eaf.2
        for <linux-pwm@vger.kernel.org>; Sun, 04 Feb 2024 14:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707087026; x=1707691826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND/xQNEJtsaXAuXL9B27wA9Puu1cUx+17iEo4moNYwM=;
        b=URzBlsfzLH1mxdhlr3/fR+IqcsEm4bDn0Q6G57lrsdeKxO/LiSTrijmNl6MdhdLgw3
         AH3zBo9cQdoAJM1aqMQSUl6cvw40JHL7CbO0kgdHHPQcNfgAGMJlrvoYgntzyAdYeF9V
         AHsnGqQnaNXDjArXCyF9CvCkN7dAjnD4aRtm4BsUjT5VHGgXNiISbkE2gCw6Un4MZQHr
         kusQmdwvNOY9gt5AEr2zkwyc8OPvBdhOTEAgh8O0MoRqhDgfT18qlQ/cFDh9ZMoQrskU
         8O4m01JocdKXwoVT1IUubdv4OxK8z8v9vk2l0OXVFIQVX5WK+o9glot0rz5W1FeAG4Fe
         LMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707087026; x=1707691826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND/xQNEJtsaXAuXL9B27wA9Puu1cUx+17iEo4moNYwM=;
        b=nf1xuWkopQtAnplN9gWEKuCHQBYHLmdDaQ1MoFNePL8ntoTqRXEdMefprjEN9pC6tn
         dqYgORg4OiLUF5itt5yCW/x0o6QYMWfODuvUhkA6OfxDqDfi7PQJGOYC5CFnTH3fagMT
         4E0Ef7H/RBV0anA4neuTfQDrDIfzaNvF0noab7pkjDrj6EzcqByg7G8E9MJdcib70TcO
         lGR19fiCkoRlYCVvyggrp5GjslOjSl3PgLKny2ElgerbjUyVhaerCG4P7wZRjbGHgRs+
         wAna7Iu9E8zMQE4Gg+3cuRgOtII5fyC17fB9aX6oEKAJ4cIcwqqEmC3TVYyiY3fLtiq+
         vKoQ==
X-Gm-Message-State: AOJu0YzgI2BQ7D6xbyC0R5592v1NB2Pk7IWGoSF7RlOtMGYcuc5mrN6M
	i2CGIzv7jA8ZRxPXkxs6isjODiCU0a892EbEC8VwFSM0FqGBhjtMqvwCIRBsl89ZZNs2rRKRHdU
	slZ3/FdMF7I4wkn9RNXkLWxF3v0oqNI/TYc10aA==
X-Google-Smtp-Source: AGHT+IHzIaj7GCH/uxo3t/1i9DwbTH8xWDIC0mPBG2Zfzu0hBnmg6qiP53I/nXOtUScVQmuBFPUMoezjef9rHhKj+do=
X-Received: by 2002:a05:6358:b017:b0:176:a0ad:131b with SMTP id
 l23-20020a056358b01700b00176a0ad131bmr17245569rwn.16.1707087025901; Sun, 04
 Feb 2024 14:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204220851.4783-1-wahrenst@gmx.net> <20240204220851.4783-3-wahrenst@gmx.net>
In-Reply-To: <20240204220851.4783-3-wahrenst@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 4 Feb 2024 23:50:15 +0100
Message-ID: <CACRpkda7w2eQrttvP2EfFeu62ZDnEAMCjN58At+v9Z-3_WtL3Q@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] pwm: Add GPIO PWM driver
To: Stefan Wahren <wahrenst@gmx.net>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	andy.shevchenko@gmail.com, Angelo Compagnucci <angelo.compagnucci@gmail.com>, 
	Philip Howard <phil@gadgetoid.com>, Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 4, 2024 at 11:09=E2=80=AFPM Stefan Wahren <wahrenst@gmx.net> wr=
ote:

> From: Vincent Whitchurch <vincent.whitchurch@axis.com>
>
> Add a software PWM which toggles a GPIO from a high-resolution timer.
>
> This will naturally not be as accurate or as efficient as a hardware
> PWM, but it is useful in some cases.  I have for example used it for
> evaluating LED brightness handling (via leds-pwm) on a board where the
> LED was just hooked up to a GPIO, and for a simple verification of the
> timer frequency on another platform.
>
> Since high-resolution timers are used, sleeping gpio chips are not
> supported and are rejected in the probe function.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

This sure looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

