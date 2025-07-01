Return-Path: <linux-pwm+bounces-6633-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EA0AEF659
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1113BA769
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 11:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB227055A;
	Tue,  1 Jul 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KSc2qsg0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9148821;
	Tue,  1 Jul 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368818; cv=none; b=WQ1TPqAP9vKmeBUOuxPegMxtG14KasY6WnjUc/R1AgDD1iYlbQiGxrQS25MRD/nqByymtoIOMAiRN7pDp02kgT5614garCbgREA5pU4ow8w/eTclsUWyjLOB1qV+1P/JLHARY1xOhzp/qUJrU+TjMTBIiULhStipX21P829hTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368818; c=relaxed/simple;
	bh=6NvyQEt4one+DKAwE2RIPkutjUkQuQadH7DyHnGtB34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beKZxd+Lp4bRYcJFIcv3fQKvFRc/wRd+Oqern2yKGsyaqhe6SQkGFa1EqeF+zo1dyUfLNaR/cNqc8rWmrN7Q3Od09FiWMIm8WTlSFovFp2IAx7jlxV94bVQDfRc9jBS908EXP9Mxb1fdvSJNCOPZi0dr1x/a0yyyl+xJOySCZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KSc2qsg0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 5018A78C;
	Tue,  1 Jul 2025 13:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1751368792;
	bh=6NvyQEt4one+DKAwE2RIPkutjUkQuQadH7DyHnGtB34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KSc2qsg0Zn/jhb2/nc2LjA+UWJLDvQbd6PyEeWViejh3xJ4CdhnU8unrZLyRAUl/R
	 /Dqg643nt9PvWm4Wj8Opp/bProj7hJzpNIt4HMzEoabC3Uy3Xi/U9ac9q2/FG4cwe+
	 5whM2pe3UVFoExQkU43usyvquFcjZLElxjd8rAGo=
Date: Tue, 1 Jul 2025 14:19:48 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Lee Jones <lee@kernel.org>, nuno.sa@analog.com,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250701111948.GK15184@pendragon.ideasonboard.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
 <20250619133834.GC795775@google.com>
 <d20682874dbd65acde8b80efa004706a09b23248.camel@gmail.com>
 <20250701110522.GK10134@google.com>
 <15ba1febb0f0acf4057af64c5c84db0633cab864.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15ba1febb0f0acf4057af64c5c84db0633cab864.camel@gmail.com>

On Tue, Jul 01, 2025 at 12:09:11PM +0100, Nuno Sá wrote:
> On Tue, 2025-07-01 at 12:05 +0100, Lee Jones wrote:
> > On Fri, 27 Jun 2025, Nuno Sá wrote:
> > 
> > > On Thu, 2025-06-19 at 14:38 +0100, Lee Jones wrote:
> > > > On Sat, 14 Jun 2025, Nuno Sá via B4 Relay wrote:
> > > > 
> > > > > Hi all,
> > > > > 
> > > > > Here it goes v4. Main changes is to drop chip info based struct and
> > > > > directly use an enum in the FW .data pointer, use the notifier API for
> > > > > dispatching events and multiple calls to mfd_add_devices().
> > > > > 
> > > > > Regarding the last point, I think I could have used multiple calls to
> > > > > devm_mfd_add_devices() and avoid those gotos in adp5585_add_devices()
> > > > > but I do not feel that would have been "correct".
> > > > > 
> > > > > Thanks!
> > > > > - Nuno Sá
> > > > > 
> > > > > ---
> > > > > Changes in v5:
> > > > 
> > > > In future, these should be inside the patches themselves please.
> > > 
> > > Hi Lee,
> > > 
> > > I'm about to send v6. I just have a question regarding the above. Do you
> > > mean to
> > > have the log in the commit message itself like DRM or do it with git notes?
> > 
> > I have no idea what git notes is.
> 
> It pretty much adds a note before the diff stat but with an annoying "Notes:"
> line. b4 seems to ignore it anyways.
> 
> > Simply place the Changelog inside the patch, just above the diff stat.
> 
> There's already some emails about this on v6. I ended up doing it DRM style
> because tweaking the patch before sensing is surprisingly non trivial with b4.
> Unless I missed something.

You can record the changelog in the commit message below a 

---

line asyou modify commits. That way you won't have to write the
changelogs when sending the patches, and b4 should not cause any issue.

-- 
Regards,

Laurent Pinchart

