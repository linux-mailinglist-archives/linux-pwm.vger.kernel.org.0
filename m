Return-Path: <linux-pwm+bounces-5580-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6477EA9411A
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 04:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5B519E7E23
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 02:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B94207A;
	Sat, 19 Apr 2025 02:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQDIwF49"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE616136E;
	Sat, 19 Apr 2025 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745030769; cv=none; b=Lcb1gjXrll8sRrb+m8Zxd5rpLtbC3bHch/cVKDlQOZJBFueynZnmpOrShGPfEHreKyCaDyAVVPSc+VD3gOn8yY8FcHvtRJQ92DhVWli92jnA2KUJUH6MvQvABtcLG/HiHEjmUXI4630AMJaVp9MgRrDY/q9hVofvA1GnQLn8tgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745030769; c=relaxed/simple;
	bh=gvuJrMLOdmnOm91Siq3JvFcU14VhzFH5Pwm0vWjpAZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPOwVveHeZDAos98PFYiXcoRKkZptdegbrRd4gPYsQD9In9mpZ+kj8z7AJF9qiA0AfNSw0m0H/K3QqUAjI+tAD8G9eRoKdo+mPA6eOXwadd/vz/42cqYJTeU0vuWTJ9BYESGliyoOLm1/y8FI/0AOq8CRpH6Dq+CVhdBWKpJrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQDIwF49; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22c33677183so28443175ad.2;
        Fri, 18 Apr 2025 19:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745030763; x=1745635563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RzwzU/RPEWQh1ASxLVOsS98O+e47MbzqLttT3KONSA=;
        b=iQDIwF49ejoP3fhhfPHweQMlhdD/+65SDsrJmOyyWUkDkp8qvscR49e5hCE6xgEH82
         XJ8Crie90vpqrpTj4g9LPERMtKkXxdy2gOeUo9lJYPDPG0n+0a53v+Kfw3xUazLaeFL4
         2d6Zse/6ATy5RHJeGemwUsM+jBI8hmq9Pmrl7nBkvI9uk01rVb8/DOhHgbvgftpbEkpm
         RymQuCH+48Eu+29YztV1jWh2rw+lH61AagKoIVwB6hkQoaV38aqwKY0PJrqKzXrQo4xq
         Nfx8KrLR5D1/RVRcO5O50jNFrpD71/Ym3dTCUoHu5rJ5cAFviwQv/19UqPwc9ldq2Scz
         cd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745030763; x=1745635563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RzwzU/RPEWQh1ASxLVOsS98O+e47MbzqLttT3KONSA=;
        b=H82AIyre1hsy+lgaghQZC+t90DnYyebVgnHevXElM0efpa4yF0kBzWccX1O3DTBEEr
         Xn0/jrsGteOMpM+B2tlKhvLAuLE80LwWhvYM93FXe9BN0p1/8h6AjYs2bdmdEHfIxtkj
         fM8Sp4TkdVvAXxMOTQqDm8amyOPVptUCi9L5Vq6n6Tuy4x7Ecei0mtgCi5F6F1j39Y7R
         LMdGxMgv3DFmt1oPaT3Um2QVHIoKOspwavKW8LXTVi/LRcbFe7V4EkNvFztyERA9toI1
         1+qeXuxlpI3nYBfYN9g6VWe+XNF/afFYZxj+5KmVrgB7EWHrRLDgcU/cIfzt1Kp8pIYc
         x9wg==
X-Forwarded-Encrypted: i=1; AJvYcCVYSv0yiuWCF0IFhOC/y4GWYoPeWhWzm2yJ7mjHCqod+eXI/ueFQwoOtQxks0p6VOiHOyidt6LfCLEl@vger.kernel.org, AJvYcCWJv+CVAogMVxCK1iQzg7x1/iWGZ/XsqAXcCbJdQKl/Ztv5qiaVs8FcqUDjO3x67gRhSoqITi/pfNn7cF0=@vger.kernel.org, AJvYcCWLMhd2rCVYfcKX4eNtciUc0ikTLh1oNUiMbErvzzGdqtZifmjM+WpVmRarSP09x3urdeimdrulcshI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WaCyCYwwa7LGBCUAddOdngQsvN4zIscsGiWBThg10uY05kWi
	QZFAYOWOHd8CZ+Ykx895xJMOTlRnacOLVk1IAfS22xrJCZBSX8IO
X-Gm-Gg: ASbGncv4k9OmY1Rxjg354wf2b53vCrcwGnIl/xrVOxHGcbeZ3qY+fWwXbS4GZEmjPhQ
	uA6W/98DzU+8+1Bo1+TehUUYSVbmXQUJJmWAfq76zUdHlGG/VO+owKl61iGayPTON5icM1OVm0J
	VE3G5OVUy/SJAmbbICegoQXCVuyEXS9dIeRYnElqg3eCrEkOGkYZnUygK+vyOrhijY8w71kNN4l
	/CEV+wCgIrGJ0SlMrqTKL14quLBdZq6Q97eL3cdwHG9wy3UAspOTfzNCEg10sq1ZSfQXzweABFH
	a7kuHRSrsnCQPqhTf1AHKEZ5XcBSpOzKzK2LnVftJg==
X-Google-Smtp-Source: AGHT+IELLIfeh/WcHCnTSkEtDW6ClN6QTw3XxGVttzwpusfdY55BW4MXr2PLJVWbJ9rYaZ517CtvaQ==
X-Received: by 2002:a17:902:cf0e:b0:223:5241:f5ca with SMTP id d9443c01a7336-22c5359b672mr57491585ad.20.1745030763015;
        Fri, 18 Apr 2025 19:46:03 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:eaea:89f0:c84d:941a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087dee864dsm2012343a91.6.2025.04.18.19.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 19:46:02 -0700 (PDT)
Date: Fri, 18 Apr 2025 19:45:59 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 13/17] Input: adp5589: remove the driver
Message-ID: <uaasqxltp5o6owr2avd5x2okukvl3qgq7nuvajb56oiocwn5jm@eyoqvhlmday3>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
 <20250415-dev-adp5589-fw-v2-13-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415-dev-adp5589-fw-v2-13-3a799c3ed812@analog.com>

On Tue, Apr 15, 2025 at 03:49:29PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> The adp5589 support is based on legacy platform data and there's no
> upstream pataform using this device.
> Moreover, recently, with
> 
> commit
> 480a8ad683d7 ("mfd: adp5585: Add Analog Devices ADP5585 core support")
> 
> we overlapped support for the adp5585 device (gpiochip part of it) but
> since it actually makes sense for the device to be supported under MFD, we
> can complement it and add the keymap support for it (properly based on FW
> properties). And that is what
> 
> commit
> 04840c5363a6 ("Input: adp5585: Add Analog Devices ADP5585/89 support")
> 
> is doing.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

