Return-Path: <linux-pwm+bounces-6605-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16612AEE789
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 21:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2323C1887ECA
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221B42E5435;
	Mon, 30 Jun 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JObxZ4+B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C861D5ACE;
	Mon, 30 Jun 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751312058; cv=none; b=fksgt8Y7IP2oqizfXC2w25ThB4Kby8BggqBShlEwWsTs3Cx2YcnVzd1dwUOZrovV8ZYbWsrOl+zHJ49GoCjU8jL4V7/eNmHULaFIf8t+O4E/J/4wfXD7RDdaKxPgoMhTEC1E8tWwcQJu/r6dnpXmy3EwlDF79NsBMkZZ4TDo0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751312058; c=relaxed/simple;
	bh=0747yHzYoacqbcat5XpVzvM+JfTUMpvg7fNSMl1X7Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diGC7ZL7d3Xt1Rnj8QQL1sHjSOWYjRWyhEPOFIwu4korJMEwS+Kj6zyC4EtZCLGYcqc8uY5zYS8DobyKwlVP37LFU68VOE9gic1o8xC7hBcN8nbNZdYNGMJnorqzjww3C6mzUPnxU33oU3nFQT0eNLLd51aLKwSgeg20Ipq10oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JObxZ4+B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33677183so40442485ad.2;
        Mon, 30 Jun 2025 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751312055; x=1751916855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LClbUcK/fw3e4Q94laANH2vgsQ+wqepfGpDL1L6B2Sc=;
        b=JObxZ4+BWc7mPBbJ6EKuTPbX4iLHyoQu8jkyzmGS38JMDnvord9FEoCXJVM4m8CjAm
         OAgTD7iYZEx2umADo/wl/SO4/0dVUACB7jtZZWoAhLTfAuD2Bsxpe7ciGAKn1HaICCpG
         uVWs0+3mxMIdo9gqBj0QwD4v3in/uTsGqljSq1TOjLjpZYdnHfU+Lh3629n+VMpDCoeO
         vrice0we0KD2Vp438rziX1x+gKukQYrPx5iBeT06+U9BMh2hZtBfus78E4rp5Rt19ubM
         TYLvY6N10czREq5UncYALEg6U5YMKGAdV7aRG4kZmmUD5n4CAoBAP5yvP0PxsI4jlHvY
         /cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751312055; x=1751916855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LClbUcK/fw3e4Q94laANH2vgsQ+wqepfGpDL1L6B2Sc=;
        b=EEfc5nIzfBB3o54UDKmA7zVfd1DUT6hEy8eu/yOcZ2lMCgNaElbiKdypbnRCbWbblO
         3Gho3sIvxPTz+aiEiGuBUkUAHBI9yhYodWWHJ8IgQfklLaS/GhTF/3myUWLh5GKPfwDS
         xuDj8VsWQ+2cnHP8sgN9ou0VzDCswWn9c5p5PO39c9SCcmxsbCZK2bAk2piyWqihU7YN
         s7H6lipwMxX2Ob+x52eJ2lkjPnosXhxaVqufjsFYov2jfJBy68AN70a4zvpqURe6HX5k
         zSSpysimyqCBbZp+X1lxDMj0RfmMooU+IOMkm+YgSZqaaZIClYAAJw2d9OTICwoYGL+w
         QRig==
X-Forwarded-Encrypted: i=1; AJvYcCUwX6XwKiViPXSVza1NdMGdcEMzSRiTqXDATNav/cz7BX4aQKqcZ6p2e9+NRLZmfaCSoID9HjQeahU6@vger.kernel.org, AJvYcCVpNnVoVnnhD0IrUDGXS0dC00b1LPcABAHBimctLAzzZppQOTaHX3TVCMC+GavMFvWDNZltdvGVdX4vhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyE1VuYwzxMVAnnmJYJXneVYCmkWxf3vsQ4QMiABbnTR1WfTO9
	NObzgpXJ8RpicBdjRO9GCff1NZt00sYPzuYlOx9FJXRKa2DO8J/5CrVr
X-Gm-Gg: ASbGnctAswuTlW6kFJav9PvOAy5AGSe4tpKkhtqy9VJ+kM9hXBNoAnJMBNXH8fIZyYh
	7Xi0W6yEcMMn+cQWbsjyxfB9YEVv6HGVLmWysRb8SBIYnjuGYlsehmAflZainWMOC0t/+2pvD/H
	qeVzWVWB4Rc2wnhlgrfodoOGUatdMP/+3fIkmEusbC18wOYYNYUrab6OubTt0i29vaaKF1yLEB3
	x1AoiypVLQQfclYF6Tlg3ulyVCuIkzI4zyr261TWqKOgs+npBttyjItRwZGafiOdQT/xrjVa6pV
	mUHKCGUnPa6mjuWBjK0sUHgvDhmZaUFvN7zaY48Lx/o5JSiTGAO7JbLLbgJfKA==
X-Google-Smtp-Source: AGHT+IE8vnVLXqKVbhGhHLTWKYGZSGv4W+fWSHrq6BAlCAJDLbfAG+5HfUvZZvDFKSyEEv0Edu9wrw==
X-Received: by 2002:a17:902:ec89:b0:235:225d:3087 with SMTP id d9443c01a7336-23ac46821d4mr177827545ad.30.1751312054709;
        Mon, 30 Jun 2025 12:34:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c92b:c666:1f8:990e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39ba5bsm88813235ad.98.2025.06.30.12.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 12:34:14 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:34:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] Input: max8997_haptic - Optimize PWM configuration
Message-ID: <gu55xwoyr2zolonk2dxupmflcpgqgqp4kh4v4ulpluvsdwik3r@gm2he7khmtut>
References: <20250630093718.2062359-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630093718.2062359-2-u.kleine-koenig@baylibre.com>

On Mon, Jun 30, 2025 at 11:37:17AM +0200, Uwe Kleine-König wrote:
> Both pwm_config() and pwm_enable() are wrappers around
> pwm_apply_might_sleep(). Instead of calling this function twice only
> call it once without an intermediate step.
> 
> Setup the PWM in max8997_haptic_enable() only where it was enabled
> historically. max8997_haptic_set_duty_cycle() is renamed accordingly to
> make it clear this function is only about the internal setup now.
> pwm_config() was called earlier back then, but that call has no effect
> on the hardware when the PWM is disabled, so delaying this configuration
> doesn't make a difference.
> 
> As pwm_apply_might_sleep() is used now defining the whole state of the
> PWM, the call to pwm_apply_args() in .probe() can be dropped now, too.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Applied with a couple of minor tweaks, thank you.

-- 
Dmitry

