Return-Path: <linux-pwm+bounces-2327-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B908D7D23
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 10:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390FE1F21503
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2024 08:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBCB5914A;
	Mon,  3 Jun 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oo5FhNmx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC6D38382
	for <linux-pwm@vger.kernel.org>; Mon,  3 Jun 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402637; cv=none; b=YkifwJsDOxejHcq3qjj/iOlP8J1pQWeRyPQkfJLl4K/HVW/0CdncJ3TTr95Dnjry7BMmsz583fZucBggx3d2GY1AeHkKX1PYmMc5u6HvtWUQSwcSKsyz1xRUIuRIsG4Ko0cUB28XXegyZ62DPZtX37Qjr1QDPdIRKp75kXY2ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402637; c=relaxed/simple;
	bh=ydnxOWl2dBIzZnuKszypKD1rZv/wX9sApZtO89araoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWuUAcBii+6Y/f3r2vQcEpb0w+KIY7PX5l+Ge+SPZ1nVaDRFz3Hi3DY7+IsPVUWtLyu6+jJAKRrVIcmxwXiKLmO9dVxqnXGkdgViI8vJchjXg7+XWjtwv9AKRIgS+em15k511V4d9AhE5FugO83hIhPJf42AzfWJJ8nk5t2m32I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oo5FhNmx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaac465915so8347291fa.1
        for <linux-pwm@vger.kernel.org>; Mon, 03 Jun 2024 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717402633; x=1718007433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydnxOWl2dBIzZnuKszypKD1rZv/wX9sApZtO89araoc=;
        b=oo5FhNmxxzh2dMF5RV7SrdfAw6w7RcUnRHpzcUPNfWvP4zbTgcYRRv3QGcQK7Gw/al
         HiiLXBseusuD82VihyZWi/VE93QrZBoojyPofZ7qmP9Mwi5iB8rh1soFf+wJMgL5x4sS
         xi49gGMsttsbN0vj73s1hUHgBcK8eCpMLNXnFGqKsy4mTZzszuOiO/AzF9NmKyU1yTel
         jUQcaFLzt1yzJn3wqxjlrx3j+SZF9Pego5V0MBBd6+McZMn3JR/wiIzKMO8QAHsoOrXg
         XkPe/cX7L7IrdukY5uLsqAQ2ldKCLwM0F6ppc1NfqUMr35OOwbFS0sbd6p62kdfL64dW
         PJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717402633; x=1718007433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydnxOWl2dBIzZnuKszypKD1rZv/wX9sApZtO89araoc=;
        b=r4RMmoSNASGvyMM5eeJX5QhvHUIph1WBcSHTNXU0+FJWT19MsoJzaUmF4b8Jy5iKRo
         KfN53xI4/wqhHL6o4DKO5o2AKYd+gbd1RO0dF1fgd/ew8Hj9wOqNA2xQUKx5drZS+Kjf
         kqdDwDPl1ZlvrQ4y2BwwB6wEWtsgeD83AVBEruLXeLCNWBhtWHstakYxj24IFJ8mkpYq
         dN2A8biZHb11Pc0nH0ZPDoi7khHUldpvyuJqTHX7PHgY1fZi1ncAjuQeLqkofIBHjbHh
         8roOyzAB5NTCS9b109R8wwHa37jNhvv3qp5m+v7nXYGVffxrVRGxQ6onStCgy5vnvoq8
         Cmdw==
X-Forwarded-Encrypted: i=1; AJvYcCXsupVR2DnX0nw6BTfYauf5l+qyv53+TCmkuMpQ1Z0xaRtJjSbRHHXHr5QBF2HYe/LuWoTy+DEgwX7gIFpYmqX/G8vcW6OLJHQf
X-Gm-Message-State: AOJu0YyaD2GBM6JDZnxtX4C+b78RSviLYH8VFUDpnMkAoploXU7Dy6CP
	YAbUoAbXo543piJ8YI/ITnlyl2PgU1OnF5zP0X0t6BwOOkKR6+7XyK7LQBooWgb03gPT7FXvS35
	hEkRoGKiXXnkD8RGBa6bXwNGoO7RcqMTk1o3CLg==
X-Google-Smtp-Source: AGHT+IHxDcGbTZJ+j/v1oZ/GQHP2RF96XIwK01e+mgVay6TTL5rBsuo7fofO8lBQV2LFWa+1TGNl44QNh0Hovok1bb8=
X-Received: by 2002:a2e:96ce:0:b0:2e7:5bdd:7d4c with SMTP id
 38308e7fff4ca-2ea95162ae9mr53835021fa.30.1717402632671; Mon, 03 Jun 2024
 01:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602152412.29136-1-laurent.pinchart@ideasonboard.com> <20240602152412.29136-4-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20240602152412.29136-4-laurent.pinchart@ideasonboard.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Jun 2024 10:17:01 +0200
Message-ID: <CAMRc=MeG_BN_A2p_F1UtTSafn0=kK9wCcaDYrYg6XN2DHR47vg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 5:24=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the GPIO function using the platform device
> registered by the core MFD driver.
>
> The driver is derived from an initial implementation from NXP, available
> in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
> adp5585-gpio support") in their BSP kernel tree. It has been extensively
> rewritten.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

If it goes through the MFD tree:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

