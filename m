Return-Path: <linux-pwm+bounces-3627-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E4799C365
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 10:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67355280ABE
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AE5158546;
	Mon, 14 Oct 2024 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ia14Iyll"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2931581F4
	for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894717; cv=none; b=kYD7YK1cE44I4S1tmXfZW8RhJm370jyaCPJV7eF59iKHzuXT2ebRMSK+wglyeH7WRVwss05u3KS8xGs90xqQLEzJHxRU+t6FUtrXbGRXlxyCZ2QXV1Y/Q0HM8k8cDKLsk80qFXzCVbFUZ5+YY+lFUHbguy9Ec27WFAOonHNKeKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894717; c=relaxed/simple;
	bh=xjOQIBKFQ4hDmFj1xQS3dgUvVasX3HXJz/ZWRUBk604=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJQfDWpksmGECtXCQurOVgPLrWT1ubFvxId7b3r7arTju0yRoiLWAfnEnAd9IICs7tNisrOfU2YECj5NjHoajMInkrIf0MzjA68oe4pObf4PBgmZFhQ9scfK3ODqFXrY+vTZokcVhyA6h3I5wbhAj6zhD3JSN34WAl3hmS++1EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ia14Iyll; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso786586f8f.3
        for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728894714; x=1729499514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C05OXST78BruJxxa1zeybAiFGS605rIOOOqnoYlzeWk=;
        b=Ia14IyllcEVex8j3UQM/n4lU3z6ZPqHCyfIqcLqFL3COeZbL3ADxK3Rati8OyUC2Cf
         vndDHb9lS2L/AEnD01j3NJCBFnb7gPln6c/sMYlMas2lAORlNDL8iPU3CTV6Ccno+vV3
         CuR/hB/YzYC2ryBw2DzUyOUgZyWAmtew62WKEqdBwgSg6p8eJAQwOxj17NSWJ8yDnsDE
         V+zyiWgNM9pmXtYQDeTbLkKIdDaoDPaqdDCxqnbPtGhAnjvNZJL3j1JTboYUCmtsC8Wu
         U/FcKP9UyJz/WZPPyR+lhgIFour8ppu93237a1shoY2J2icghHtxTUpqzQoQq5k+AxLX
         i/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894714; x=1729499514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C05OXST78BruJxxa1zeybAiFGS605rIOOOqnoYlzeWk=;
        b=JTWpWCy42U/2Ep2pJvAaT2/eBCWD3urUMIiNs8juaRrAMtnWMBtUIO/DbnkVZkZ9OI
         Jz7uL1kLtt0Eo+QwjFi+EDUlPFeLtk1WWszJC544w2f4xNeHUkoWTDsI+8eNWw8/SOM0
         3+K37VJVGUy/CG+o66EV8d3srfVAY5mLe58lu/xWLfXtKQOwJWoW+dZQf/EJFSo1j0mz
         GHRkPu9EvsMrdXAzzIuGwEGqteglT9QnrwATeNN6wABiSG0R4RmBT4eKhSUf/9lIIEvJ
         jIOnErYntPm9lpIeFFv+kfqfGoSvNUywUltkn7n/I/NE0lM041PTDH6b2bK5dSX9O+S9
         m3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFXVH96e4HllhEiCchGC415hnFeCGP1oKHt4kb/a0uYY0xGzI3RkNa137Uh4kRY/R8hPwne6loRgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4qCmpX4N2gl0dV6k+0dhRjHXFKr42jmW9HIaG2YDtGfJIaRM
	NX6exKtsEGzb0ejVgmFFwEHPxgmdYuBT2lBPthYXORnd3ZGD7RJYJjZqoi0AR2c=
X-Google-Smtp-Source: AGHT+IGftJe+CXGllU0M8y7/IKDb429f7k1VevaNKk/gKa8H8ugNvRkINgUHkF1YS1uTi9NYbjc9eA==
X-Received: by 2002:a05:6000:e85:b0:37d:4d21:350c with SMTP id ffacd0b85a97d-37d551e1303mr6392447f8f.13.1728894713825;
        Mon, 14 Oct 2024 01:31:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:de54:ebb2:31be:53a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ed69dsm10737698f8f.92.2024.10.14.01.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:31:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH] gpio: mvebu: drop dependency on OF_GPIO
Date: Mon, 14 Oct 2024 10:31:34 +0200
Message-ID: <172889468795.57095.15111681852340725345.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008081555.23465-1-brgl@bgdev.pl>
References: <20241008081555.23465-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 08 Oct 2024 10:15:55 +0200, Bartosz Golaszewski wrote:
> This driver doesn't really depend on interfaces from OF_GPIO so the
> Kconfig dependency can be dropped.
> 
> 

Applied, thanks!

[1/1] gpio: mvebu: drop dependency on OF_GPIO
      commit: 3a5ca23bb65169f2f79727c51a5495a2d7a5166e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

