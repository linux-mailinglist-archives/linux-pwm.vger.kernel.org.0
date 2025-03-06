Return-Path: <linux-pwm+bounces-5114-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B9A55A2A
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 23:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9EE07A66CF
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Mar 2025 22:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961D927C840;
	Thu,  6 Mar 2025 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qor0ZMtI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F96A2D;
	Thu,  6 Mar 2025 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301462; cv=none; b=fHqKSs2ros0PPfsg9360K5iX9E9uCWgwxIxk6l8NCqdPvLKxxjiOypKaLJ1rmiPFhcMZGPWrZPmIB6VI9Xi3sJ3UFO6OANpzY0oLTDw+xz07+QvaXz857SWb1R5b01kWhVTZnObbFiWzqWqyCyhYTcPo9HO3tp0WktRrTaN7Yjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301462; c=relaxed/simple;
	bh=PQNLXZ0BI7Zw90mYxll0zwWrtFEy7breMuAbqFr1dek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IbG5V7mfD7nvcCbog3GattNeH4HLqQN7QpoMTGEyqEggy1HBNLUS4rRcggJ17oSrsiXmxD7u4FNOnTIltl7lYN2BWefs2BTkdDAvDR5NRGzwEst4Q8uGlJYCuIh/FxS+ubCgsHFOSZP8WOJqTB5Donoe29plzE1pHj716bmAaEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qor0ZMtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBAAC4CEE0;
	Thu,  6 Mar 2025 22:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741301461;
	bh=PQNLXZ0BI7Zw90mYxll0zwWrtFEy7breMuAbqFr1dek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qor0ZMtIqlsb+J0MHUg5TopHRsOmRbItCbyOB6VhkI97wUSgYXiXAlOToKWp/BtXW
	 LPt5iR2yIA3M7pMTcUVNfXvMTtfG2CBVdrr7MND9AX9NUo0Zxi23glCQwMgz2iF6bq
	 114Tb1k7mecVi+B/g/mn/+cRXBtEdEd2VRhc0fVnOzZ7Z07+KdJ4M3ygs2iZu23rFq
	 o+HVT5mgGkp7v/MZkVNRJaNVwgynWWqZ+8sTFEBILZZpkrF6hX+ic+upEAdO+1Yu19
	 /jQXd3xBEUUgfA93Lxn1piBkPcyzvopp1MStqB5fQ/w6fft0dlUFtHL63QaZ2REehE
	 cUJAm22V72oPA==
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Michael Walle <mwalle@kernel.org>, Bamvor Jian Zhang <bamv2005@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
In-Reply-To: <20250220-gpio-set-retval-v2-1-bc4cfd38dae3@linaro.org>
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
 <20250220-gpio-set-retval-v2-1-bc4cfd38dae3@linaro.org>
Subject: Re: (subset) [PATCH v2 01/15] leds: aw200xx: don't use return with
 gpiod_set_value() variants
Message-Id: <174130146134.987559.8662566490718210141.b4-ty@kernel.org>
Date: Thu, 06 Mar 2025 14:51:01 -0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Thu, 20 Feb 2025 10:56:58 +0100, Bartosz Golaszewski wrote:
> While gpiod_set_value() currently returns void, it will soon be converted
> to return an integer instead. Don't do `return gpiod_set...`.
> 
> 

Applied, thanks!

[01/15] leds: aw200xx: don't use return with gpiod_set_value() variants
        commit: 5d5e2a6f15a6c5e0c431c1388fd90e14b448da1e

--
Lee Jones [李琼斯]


