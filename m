Return-Path: <linux-pwm+bounces-2858-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A629378E8
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 16:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871291F22B30
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F68314388F;
	Fri, 19 Jul 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VxC4Lmim"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709211442FB;
	Fri, 19 Jul 2024 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721398050; cv=none; b=tKgtKHymM54/bnH8fU0gq2n8bxzStzyLhtVIXrQUdJZocCiyAneStSXiM55/XGqbqFZk7k07a3a+Xv+k0LBFdlbFUQ5cbt2NTsZdO6QjgKFQ0CNL8okHewG7VGBwdBFkZhyl49ef6n1mPtealMtzuzyuB8YHFL93aIwaqJbrI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721398050; c=relaxed/simple;
	bh=20zvaO11FrsyesRbtYuAMn98AAwtMwMZY+T2BXR0fPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pThY70Z9W/iU78+JdWyBFDqx95BAFWuMTAnsqU0sS4utcJJxjLIa9xxasK6gfiD62BOE9KfWtEok7svk9THuG3AEU/L3y8sy9zY5WGyyIgIeePjG4oA9AQeGCSv2ZkvT53HACzeTuHutgSlTlS5T6pmTj0P+50MdQgpV7Q7Vn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VxC4Lmim; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 558F8471;
	Fri, 19 Jul 2024 16:06:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721398007;
	bh=20zvaO11FrsyesRbtYuAMn98AAwtMwMZY+T2BXR0fPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VxC4Lmim/3zV35bA9lJhqOlZXUxGxUNN37T3T8eL040PZajKVEGaFWYg7QJX3vYc8
	 TbY664n9PNaNs2SpgRe5W2CY7gSYm7VxHmjEZ+lW1IRC4Lv6zvL2SMZaY8d92HR5SH
	 KK7qaclJr374JAxm/fmcjlZWbX4GFVgvs3rhR+10=
Date: Fri, 19 Jul 2024 17:07:11 +0300
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
	Clark Wang <xiaoning.wang@nxp.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/4] pwm: adp5585: Add Analog Devices ADP5585 support
Message-ID: <20240719140711.GC637@pendragon.ideasonboard.com>
References: <20240608141633.2562-1-laurent.pinchart@ideasonboard.com>
 <20240608141633.2562-5-laurent.pinchart@ideasonboard.com>
 <ZmcWi08u6-u4MyKu@surfacebook.localdomain>
 <20240610152833.GW18479@pendragon.ideasonboard.com>
 <CAHp75VfcTHty-Vzcc+B4iMk33qS_AafvU10Qn3AQftrfQRBebw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfcTHty-Vzcc+B4iMk33qS_AafvU10Qn3AQftrfQRBebw@mail.gmail.com>

Hi Andy,

(CC'ing Mark)

On Mon, Jun 10, 2024 at 07:31:11PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 10, 2024 at 6:28 PM Laurent Pinchart wrote:
> > On Mon, Jun 10, 2024 at 06:06:51PM +0300, Andy Shevchenko wrote:
> > > Sat, Jun 08, 2024 at 05:16:33PM +0300, Laurent Pinchart kirjoitti:
> 
> ...
> 
> > Andy, we're reaching a level of nitpicking and yakshaving that even I
> > can't deal with. I will have to simply ignore the comments I disagree
> > with.
> 
> Do you think using bulk APIs is nit-picking?

In this case I do. If we were dealing with more 16-bit registers in this
driver I would agree with you. This being said, I'd like to get this
driver merged, and I'll burn some of the mental energy I've recovered
thanks to the last two weeks of holidays and submit a v5 using the bulk
API. It's getting mentally exhausting though.

Overall, I think it would be nice to improve support for variable-length
register maps, in a similar way as done in include/media/v4l2-cci.h.
This driver, as well as many other drivers, could really benefit from
it. Mark, do you have an opinion, is v4l2-cci something that we could
fold in regmap itself ?

-- 
Regards,

Laurent Pinchart

