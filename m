Return-Path: <linux-pwm+bounces-2857-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC389378C6
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 15:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7130B21844
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B2614389B;
	Fri, 19 Jul 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LMS6fpn7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C3225757;
	Fri, 19 Jul 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721397335; cv=none; b=kDnfpi7tQXsaJxRuR/+R924+peM1GyPs+SgJCqVHC9IasYchyAy6QMCk6gmu8aax/oyzY0YtrFMiHHa0ShmBSQWuJ2NDC5n5wsbDXAvkzwU7WymOe1bc4X9uiwz1flgq6cyJ4/vlW4uR9vLS38Pughjz8Bu5xU1I1arAay/Uc/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721397335; c=relaxed/simple;
	bh=3nhR39DwmWoTCy8/EM9HP2pdRH10FR7GvM552Rvo/kE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD+dyWF+8pgmCQcrfVcMKipqH93++D/h0WB4H3/rT/SvTtJvIfjwp0uU/InE1Abs+7jxlGV/1L/gbj9saUR+7891YAIvttaohq49Fr0LrPL9HdTw5UNFKSzbThqSDF7hA86wZgkTuHAiGuURbQSxcJFBMtYhIGPzaTMtFBI1ucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=LMS6fpn7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 13C15397;
	Fri, 19 Jul 2024 15:54:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721397292;
	bh=3nhR39DwmWoTCy8/EM9HP2pdRH10FR7GvM552Rvo/kE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMS6fpn7uYLgKh2xCIXwG5CczqmGw4NtA8TijpJDMpzucLxOuL55Ddc+tbpbT40Gt
	 usroroUTPeq7YPUFrghmC/HRaI/ZJ7xefld+QbjmXyXm/d1TyIn2z6+1tMsler31l1
	 v1UcVOEywqiDRGxV/9Tl0Ya4Zbl/Kz7fEhtsdHDM=
Date: Fri, 19 Jul 2024 16:55:15 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>
Subject: Re: [PATCH v4 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240719135515.GB637@pendragon.ideasonboard.com>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-4-laurent.pinchart@ideasonboard.com>
 <ZmcYnDf0YIWA9A85@surfacebook.localdomain>
 <20240610152555.GV18479@pendragon.ideasonboard.com>
 <CAHp75Vd-TZYsm+fe+o1XvDYGHO6sDqZhMFqojowRx2scwxEhLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd-TZYsm+fe+o1XvDYGHO6sDqZhMFqojowRx2scwxEhLw@mail.gmail.com>

Hello Andy,

On Mon, Jun 10, 2024 at 07:29:09PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 10, 2024 at 6:26 PM Laurent Pinchart wrote:
> > On Mon, Jun 10, 2024 at 06:15:40PM +0300, Andy Shevchenko wrote:
> > > Sat, Jun 08, 2024 at 05:16:32PM +0300, Laurent Pinchart kirjoitti:
> 
> ...
> 
> > > > +static const struct platform_device_id adp5585_gpio_id_table[] = {
> > > > +   { "adp5585-gpio" },
> > >
> > > > +   { /* Sentinel */ },
> > >
> > > Drop the comma.
> >
> > I prefer keeping it.
> 
> For what reason?
> The sentinel should be runtime and compile time one. Why should we
> make our lives worse by neglecting help from a compiler?

Do you really think there's a risk here and that this will make a
difference ? I do appreciate most of your review comments, even
pendantic ones, as they can help making the code better, but we also all
need a little bit of space to breathe when it comes to coding style.

> > > > +};

-- 
Regards,

Laurent Pinchart

