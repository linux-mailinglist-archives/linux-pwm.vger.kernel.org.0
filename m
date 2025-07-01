Return-Path: <linux-pwm+bounces-6630-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF96AEF60F
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 13:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB33D17FC6B
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4291427145E;
	Tue,  1 Jul 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUo8IVhH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5CD270EAD;
	Tue,  1 Jul 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367929; cv=none; b=Wf3sgjMM8gVeyrbqxMAweBZ4OpUnY58PA1en+oyJG9P1sqbdVlKJLV8jaa6CDXc30TP1duzzOoMg585cS/ZDXG/qXv+hb/NH/BqqTsvfa8FFD+OltsVcryLShaO2Ov8bvQ6m+UDluCj/ia7MbW6/MuEm8EizOLDGyardlKnXviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367929; c=relaxed/simple;
	bh=diw1zKSfuCc17N+JAhn7SGSZnai2fAdM/N39ECYN1uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esE7Cgt/eXIqdgA0vLjtgWzSb7zsmQAxURwd+FJFk4RuRiPmsr85pk9+VIr0+etc+vcpukToXhp91Wo7p7r5o45S0u63hINshQXGtZBMR+78GznxdtitjPtFGFmGAucjo6DLw8i6YhSfg8cjLU2b41le3+QQF/hnnMa7UGAG+qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUo8IVhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0DFC4CEEB;
	Tue,  1 Jul 2025 11:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751367928;
	bh=diw1zKSfuCc17N+JAhn7SGSZnai2fAdM/N39ECYN1uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JUo8IVhHkPLz6ZXyA60aarRMAAltliE8akv1sHRZIgfJT7UyA0pelivDBSfMV8l+z
	 mCkY3QWdoxQWFawkVn6HKP+Tg14iYsNGiDsWvT1ZQFW1A3Q7fdgiBkTH+0WCMwzIWA
	 sNuKeO2x/gyKeY1XHAO55Kz2NxTwM4+hEPk7j1zYTsrlVf7TK0C6KxxHmDb8i/dS60
	 rHAbDiaevzKV33wKeSVRT9iIkrpTtax2kVTzMt+iuNLIlbWaJqMCBWN+TSi5zXWqe5
	 n0Dbjm3060fTYum3xF9tyJl3bJCkBFmygtNK6siTsjY9i8DlMvrMigzNwMlTkREDuL
	 LfalkPeeunYpQ==
Date: Tue, 1 Jul 2025 12:05:22 +0100
From: Lee Jones <lee@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250701110522.GK10134@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
 <20250619133834.GC795775@google.com>
 <d20682874dbd65acde8b80efa004706a09b23248.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d20682874dbd65acde8b80efa004706a09b23248.camel@gmail.com>

On Fri, 27 Jun 2025, Nuno Sá wrote:

> On Thu, 2025-06-19 at 14:38 +0100, Lee Jones wrote:
> > On Sat, 14 Jun 2025, Nuno Sá via B4 Relay wrote:
> > 
> > > Hi all,
> > > 
> > > Here it goes v4. Main changes is to drop chip info based struct and
> > > directly use an enum in the FW .data pointer, use the notifier API for
> > > dispatching events and multiple calls to mfd_add_devices().
> > > 
> > > Regarding the last point, I think I could have used multiple calls to
> > > devm_mfd_add_devices() and avoid those gotos in adp5585_add_devices()
> > > but I do not feel that would have been "correct".
> > > 
> > > Thanks!
> > > - Nuno Sá
> > > 
> > > ---
> > > Changes in v5:
> > 
> > In future, these should be inside the patches themselves please.
> 
> Hi Lee,
> 
> I'm about to send v6. I just have a question regarding the above. Do you mean to
> have the log in the commit message itself like DRM or do it with git notes?

I have no idea what git notes is.

Simply place the Changelog inside the patch, just above the diff stat.

-- 
Lee Jones [李琼斯]

