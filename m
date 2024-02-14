Return-Path: <linux-pwm+bounces-1507-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4E855204
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 19:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0541C21C91
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 18:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858B1127B5D;
	Wed, 14 Feb 2024 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyf6Myou"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4F84FC8
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934980; cv=none; b=PUVmSeBcjnPP2lozptexQpVrcLyunVhQfHpGPQHfVzQefvqa/GTx8DWFGZ0nsIIVkU8NRx5i6+bdWoW8ccoox+HVuWXSY7WqCp9KHInr8/pW3T9PoAzj/TtzCrQ709/8KEFyl7TDZlE2JeIQU3/iJIqc7vCDMm02zeUK84EEEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934980; c=relaxed/simple;
	bh=wLwB1DtHP8MzYVD+m1v4a7qcHJ8TBKOoV1Wgn4+sRSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sT3iEfepbpxvawiHHs/DOEs1TUCH39XFScYLPfmiTLm5N6afOV628U1Yu0wHZ+u+HOxzd34GGWK+I1buTsgCv00lmHQsUrjLr8s6m62v0hPwRcfbAfi+87S7emswhIqlfeDUuNu8MZuX9MDnLqT9JAFpv8amOx6I7JUJ48m2awU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyf6Myou; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b2960ff60so654356f8f.1
        for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 10:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707934977; x=1708539777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLwB1DtHP8MzYVD+m1v4a7qcHJ8TBKOoV1Wgn4+sRSU=;
        b=hyf6Myou+mVCTfNqq4E5Xc1UeuPi1AvEDNkr2TPQefVS24ezc2RATOU7TtlpXoW//F
         FwsAswY0RHzOfv16pJivV7f2QTGa4D8Robs7x3Q/yAqCUjiBr4/bWVgKKtVZs6lBTC60
         O6uiLn+yPerYwJQUkSRZRuYwt+DUmFmeulEL8wyBf4KbRJ0RqRPQgq2cjbNo91Cu/Me+
         lMOFcS6FYXVf3LLB8T2h5P9I0HZXzChil+o/wRuvJta5qddP+A8x2g1uo2+2415IE3LL
         Iob/ZnNYHP0dfzhOTp7fZFej9wlmQVIAMIxR84eAtdo/GpNs0a0urA2Nf8ylUOIuRtHe
         YIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707934977; x=1708539777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLwB1DtHP8MzYVD+m1v4a7qcHJ8TBKOoV1Wgn4+sRSU=;
        b=P2FBJG24jF7t7fWfl7ulTtt30qL8hMWoJsvcSO3EVDO79UZ/LbIR6SmbjCsCahv8+0
         cBvk9W5uSag/dn93ixY9jciten64zWpEuLoPwJ1Ag+qHKVsQDsEKmFiiOaDsijvVOP5C
         y6GcDetOxg+sdDNuNeb7TVvHwf1gqU3WAhrX6eSNkL5TsTBD3XYRrTHLCD0SWfOMn+kD
         gaS4CL+TR4nuqdlgUELpmmEiArMk2A3K32uk1tJM5cURwEhcWaa1f5jUBqZTPs3xUnbm
         3O+Yk/+CwUrVuRnv9echbkt431ySvzpIgdk1JMG6+Q1mOdSq6W1mV6B6KF8sr4xAcZda
         HcCA==
X-Forwarded-Encrypted: i=1; AJvYcCUXef3do9vMGdHurd8Whd4ODLLfVz+ZfkDTE2lDkwN4cJ/LBE7DjMYo3rev9vE5c0Yey1lLM85OLz3PjlU7gxEuiVNO/+LUwffI
X-Gm-Message-State: AOJu0Yxx0JsJD7W4wTcPK9KgDYlKvcaS7HJ6R9Dyr4fCr1mU6jfUdhmA
	JnXQqOTtJ35sqPxX/K4rodXBuwB33kxxRZ8cA96IVFPlzYpKHA7o
X-Google-Smtp-Source: AGHT+IHrGEjG3eJNNGdzkmqYrUba9T0D+o3uMWJcg+7AZomwpfnK0bX1kgKkAatwJCs5+CB4YpXvQQ==
X-Received: by 2002:a5d:5245:0:b0:33c:eca4:653 with SMTP id k5-20020a5d5245000000b0033ceca40653mr2207763wrc.34.1707934976312;
        Wed, 14 Feb 2024 10:22:56 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b00411e1574f7fsm2600537wmj.44.2024.02.14.10.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:22:55 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 linux-pwm@vger.kernel.org,
 Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 kernel@pengutronix.de
Subject:
 Re: [PATCH v6 127/164] pwm: sun4i: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 19:22:53 +0100
Message-ID: <4868529.GXAFRqVoOG@jernej-laptop>
In-Reply-To:
 <9d175b4e27878618cef2e75b6ecbf01ad5d18164.1707900770.git.u.kleine-koenig@pengutronix.de>
References:
 <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <9d175b4e27878618cef2e75b6ecbf01ad5d18164.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne sreda, 14. februar 2024 ob 10:32:54 CET je Uwe Kleine-K=F6nig napisal(a=
):
> This prepares the pwm-sun4i driver to further changes of the pwm core
> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



