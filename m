Return-Path: <linux-pwm+bounces-5172-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A162CA5F9F0
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 16:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE2119C4040
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B7326A0DF;
	Thu, 13 Mar 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smpKKLRw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90026A0D0;
	Thu, 13 Mar 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741879767; cv=none; b=t52dB/Yuvp1PaziCY+dhJ1N93Bz1N7hNHKKek7PUzPcAHs+q4m5yfZmZRvAZevZnNq4VagpmaTuIZ6jXj8e0KFPLkR0Ufv+RWn2vHvpSgf4icCeodd8D9bGKRFPNYnxBDC6eXZGfm3xmN7bpkdJz3yFKN/uuiSmVuJlrOq79Zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741879767; c=relaxed/simple;
	bh=z1F/N+uyen+sKYPadxbDvEvh55FfdtiKufmg7gfJL8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tppDc4vvED6+eQgTPDfmvLhFVpY5Zy9DN701rS1HWxem0ivc+eV7S9EXlXmMZtj3Duqd1wn0Kfh6KTS9LzhLja1+IAWuUGtcjs1KR3orE/H5ZA0XKmKQn84sEyQmSuJs06/lr2z0+f+NmWKIW0WxpSv9yYlP42w6E+WAzB67rMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smpKKLRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7179C4CEDD;
	Thu, 13 Mar 2025 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741879766;
	bh=z1F/N+uyen+sKYPadxbDvEvh55FfdtiKufmg7gfJL8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smpKKLRwdX+gAfBcRd2DR093HqdYCRagRFXKRMiEUQhQQW6yEfyq0+zNf21V/HcOF
	 QoZ15W3A/eGWCWrseJNV8gFs6rLyRzSSlhFgtLszBMmaI6uMbJ0oF2jIfpADOLmPyG
	 2XlJK8Z7zeVjkZex0RSJ9owzaoqSWysX7sjj/PJ+z0QJ3R6CR+45xkGS0khu0jo5he
	 y7vUe5Md/b9+aaL6nw0Ybq8N22z+NmDDc0k+S+RUTyrp7brnEdQquCVsJcUdsnZty9
	 ouJJ+cHesTccyWAYSUNnavpORIBS/MRGFZ2Bbfm714dgtkSckdY6ITmn0BIU1PSwCn
	 7PdOUts+as7+g==
Date: Thu, 13 Mar 2025 15:29:21 +0000
From: Lee Jones <lee@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Keerthy <j-keerthy@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: (subset) [PATCH v2 01/15] leds: aw200xx: don't use return with
 gpiod_set_value() variants
Message-ID: <20250313152921.GB3645863@google.com>
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
 <20250220-gpio-set-retval-v2-1-bc4cfd38dae3@linaro.org>
 <174130146134.987559.8662566490718210141.b4-ty@kernel.org>
 <CAMRc=MdQcxtXMUCt00=JbGY47cMMWcW8=r3-ZrMKjQkViqnxvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdQcxtXMUCt00=JbGY47cMMWcW8=r3-ZrMKjQkViqnxvA@mail.gmail.com>

On Fri, 07 Mar 2025, Bartosz Golaszewski wrote:

> On Thu, Mar 6, 2025 at 11:51 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Thu, 20 Feb 2025 10:56:58 +0100, Bartosz Golaszewski wrote:
> > > While gpiod_set_value() currently returns void, it will soon be converted
> > > to return an integer instead. Don't do `return gpiod_set...`.
> > >
> > >
> >
> > Applied, thanks!
> >
> > [01/15] leds: aw200xx: don't use return with gpiod_set_value() variants
> >         commit: 5d5e2a6f15a6c5e0c431c1388fd90e14b448da1e
> >
> 
> Hi Lee!
> 
> Can you please drop it from your tree? You acked v1 of this patch
> after I had already sent v2 (this patch remained unchanged) folded
> into a respin of the bigger GPIO series that had triggered build bots
> to point this issue out in the first place. I picked the entire series
> up and this commit is already in next as
> 129fdfe25ac513018d5fe85b0c493025193ef19f.

Unapplied, thanks.

-- 
Lee Jones [李琼斯]

