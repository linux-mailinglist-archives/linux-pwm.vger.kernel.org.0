Return-Path: <linux-pwm+bounces-2235-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07A8CE4E2
	for <lists+linux-pwm@lfdr.de>; Fri, 24 May 2024 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E91C21490
	for <lists+linux-pwm@lfdr.de>; Fri, 24 May 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE386120;
	Fri, 24 May 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9uHcxGt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B6A9475;
	Fri, 24 May 2024 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716550363; cv=none; b=A7uN/5NUoyXhV7XG9wsHfryr07En0WZwxLMcjpsk+5vZHJ8vTprAXCgv+5d1FF2xbIpUXyiGjXl05TKFEk7gV4tggS+WCdua3kl8pJsW/cWyFpKwpM3rNYdVx1j7/95YufI7A2r/YmOGZVcTFj+ZM8d2cA5oMJDqQwAM+x8bW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716550363; c=relaxed/simple;
	bh=+FdDMqfYCOb2sKqwmEoU3h3Dyjm499FpbBKjwJhpYlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm3RC6c8ex6sye1oJQ3mR0DB68Hpmyc2xlDO40rroiTFvc/vVlj2dxjl/95GaN+4TYLd650g9ZCw1IsssEtgBpBa4qwVwtWrME6F/1AoZ3opcGAswHNVzE6W3jRDpoJ2ZtFbFt7pIxjkZ7TNou9PTPLx1ndemKrUO/6ODu9hq58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9uHcxGt; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df4d7e3dc94so3691419276.1;
        Fri, 24 May 2024 04:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716550361; x=1717155161; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+FdDMqfYCOb2sKqwmEoU3h3Dyjm499FpbBKjwJhpYlE=;
        b=U9uHcxGtMgfyGEdsMk9bVoAXftS6K4fgRv0otMMVRQY6OQ7GmmvSBePryykgJLoeTV
         QG1Sch4kWHLEOs8XtEfH50DUotQ5PqNyeA2XsiuoDcwsun0bxT5TDOaAd8zpVxpsPfA1
         9vNcygkGgFc9f0eiEWyIUmA8s/sNy0N5YRVDMhoPbqyim8Z63ezt4/9/gR6+1xRthkp4
         5UpCyhZtNbuW/F+/SJ3d5rhEIke4HSuQSgHHzOvBk6n9OTjkhJh0K3NeD+ciCHPMLrot
         +YFCB4x2AZmEERtyOBYWNuZCna7f0Vgbc9oI3DWh7ctmRygsxmPDHUXKgRgL3jUyYqtE
         oFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716550361; x=1717155161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FdDMqfYCOb2sKqwmEoU3h3Dyjm499FpbBKjwJhpYlE=;
        b=FLpaxYGF1ejVCREJbaywtpgHtDPmt0OAlKNet5d1Fhvy0JcGeQ3hNQX6Wc5yUiMTxx
         wnHxXgLNInMHNN6DbAWnCX+CsDQ3HoQtIG/IVLkrv2PeAvTexXc3BJBr29+Knt9I2QHo
         E5FRTa1p5gb53ecVuE86zfJQ0uFGYjo0ShuXZ2AFsVajNzjfAI76DuilFct9sSHsBoN3
         6n4Qtf6wpZQD0qRa/li5XLDt0J3KQ4UcwHXWF7h8K188XkRJGWRVRHNP+pCncFYjsJ0q
         nrHvN117gha92Nu66C02eDFQ8POVgUxq5kdVGn0mHrFRCFKT5PL840OLAvN+C78OIMEM
         1ofQ==
X-Forwarded-Encrypted: i=1; AJvYcCUroWUuJQfpom0lgL7dPnxTIH5pfmPKngMOdyfisq6Sl+h2gu7Fr5TVG6U+xcb+pFjZYKO9TWmz9hahyUMI4tx1s4Wt0t6eALUJ099hoZTfBHdZ0KX0/fmathT2Iz4qI0LkKaPfqeevZ7eQoh7WMhDwtgXSyUAIbqS1GY7RP+mo0Rhntw==
X-Gm-Message-State: AOJu0Yxxo2MlfQO4MGSU/QK+PVaSI+vrxtQz+n41R5F/uHbtHI4aSLlr
	W7Ui1/DD5dbJWtmyl5+pGPj6a+JNKUjT1MBea1OVccHm1U+NXyX6g5UHsdH4WCmpp/Gsm+j9q0/
	9b0shDM93NDOFAdiIe559IMLlFllQrGdmbm3j7Q==
X-Google-Smtp-Source: AGHT+IEUNT8qpSYVeFnLdK93OupqdGs3ueGj/G+IJ+fEMIu7n+LnUqnYTr2e4NhRpeaNvCqdhdjlRj2DJtbwV9uDHPI=
X-Received: by 2002:a25:824d:0:b0:de5:5255:ceb5 with SMTP id
 3f1490d57ef6-df77218a263mr1853899276.3.1716550360799; Fri, 24 May 2024
 04:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG40kxGMu-TSchNezkcC_A97hzPnWU3KxeL-X-hJfPhjr_COyQ@mail.gmail.com>
 <Zk6yK3U9tgxOxcBb@titan> <CAG40kxFxE_Oj+9aCzGku0a3KFHpuW8ai=gEkV9M8==5gwmjdEA@mail.gmail.com>
 <Zk7Z-MfdF-YKWeJ6@titan>
In-Reply-To: <Zk7Z-MfdF-YKWeJ6@titan>
From: =?UTF-8?B?44GN44GP44Gh44KD44KT44GV44KT?= <kikuchan98@gmail.com>
Date: Fri, 24 May 2024 20:32:29 +0900
Message-ID: <CAG40kxG0yM0+ge3=zX4S_MQevuNQ5oWAvtmTPXAbHHk2nmSYew@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
To: John Watts <contact@jookia.org>
Cc: privatesub2@gmail.com, aou@eecs.berkeley.edu, bigunclemax@gmail.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, fusibrandon13@gmail.com, 
	jernej.skrabec@gmail.com, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, mkl@pengutronix.de, p.zabel@pengutronix.de, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	samuel@sholland.org, ukleinek@kernel.org, wens@csie.org
Content-Type: text/plain; charset="UTF-8"

Hi John,

> Does Linux guarantee a flicker-free experience with setting up PWM
> channels, or that it doesn't affect other channels?
> How do other drivers handle this situation?

I've noticed that drivers/pwm/pwm-fsl-ftm.c and
drivers/pwm/pwm-microchip-core.c use a similar approach for shared
resources between PWM channels.
They simply fail if the settings are not applicable to the hardware,
much like this driver does. However, I have yet to find a driver that
aggressively changes another channel that is already running.

Maybe you're right; Linux might not guarantee anything about this.
I think all we can do is deliver the best experience to users within
such limitations.

Best regards,
kikuchan.

