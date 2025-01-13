Return-Path: <linux-pwm+bounces-4603-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34363A0C284
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 21:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BD1886547
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 20:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6710C1CB9E2;
	Mon, 13 Jan 2025 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkxW8sbd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3D1BD9D8;
	Mon, 13 Jan 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736799548; cv=none; b=JTdL9loigX3aFscON/EdyrGCTueohWbvCWR7O78RQ7VFcjHMtEj+i7YMSESzomW/UoI6KH3kx7x8R5vyG/9nfvBYZGFqySJHVSsdHVFhcoIHhg97fcUqntgVHP8ZiDslpwq96iYIZEBjpZgH4HRtLqpMbEgFb/NyW0/Vr2b2Np4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736799548; c=relaxed/simple;
	bh=c3lmPPv3/b6KAS/VIffiGfwG5CRzGWXjT7jk6D8+TJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgeJqCs4GL3pdO29DD24ktIfrVB4wM0A8liWmPKVCIdvTUUdLt8av02sOgmIYvCpe50fr7gM9N0uUz1EzgFi5z5nO2XDSPIC1q/N54VYp0KECu/zmjjKPfS1FiLB/cdwugOYUKYsYu+vXc3ACN97YYFmZ8B5mvy+yjmZ56q497M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkxW8sbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A69C4CED6;
	Mon, 13 Jan 2025 20:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736799546;
	bh=c3lmPPv3/b6KAS/VIffiGfwG5CRzGWXjT7jk6D8+TJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UkxW8sbdpsk7wtLnAEB7RGhkZAZxXFA5EccUk131pkw+gc68gpcMJQxov6gk5CD6w
	 MYHkCokIH1BYHGKdZDfDCKwUjwgkc5jvm17m17V0+rXHJXWf6NH9lAWm+YwOGRsxwb
	 7VlG8828Fvap5UXl78UUAJlOgIEnu0BzX8BW+nKeDmYG4HaPv4CJAJ1JUjOZrVWOXR
	 FUJM/6pW4A9sU8aiCabNyhdK8oNihRH+kA2H5TnnbLYs7P9DPLN9yM7nxJOpIiotsP
	 6F4fYCSsbc0FTWrj+mabwMHH/4W7680kFUHdpw6RU3CnFhpChIY3umKi5O6A6BOmqA
	 U56l7fzEwabww==
Date: Mon, 13 Jan 2025 20:18:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <noname.nuno@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
Message-ID: <20250113201858.4b8b1926@jic23-huawei>
In-Reply-To: <9f6ae7ab-bda5-4551-a679-783ccca60383@kernel.org>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
	<20250109133707.3845-2-antoniu.miclaus@analog.com>
	<mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
	<2f483161cbe1f797a9095ca3c9f4f472d3785acb.camel@gmail.com>
	<499ef047-d3fc-4d2a-ba7d-342ff08a351d@kernel.org>
	<98dad0cd3ba55411797c1871c5ceb5f656b8225b.camel@gmail.com>
	<f47bc5f9-cabc-4cbb-b641-693f3c729012@kernel.org>
	<CY4PR03MB33993668E69121A9F786E5219B1F2@CY4PR03MB3399.namprd03.prod.outlook.com>
	<9f6ae7ab-bda5-4551-a679-783ccca60383@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 13:05:30 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 13/01/2025 12:50, Miclaus, Antoniu wrote:
> >>>
> >>> Oh sure... Makes sense and I forgot that the property is not new...
> >>>  
> >>>> But looking for pins brought second point - here you claim these are
> >>>> mutually exclusive while datasheet suggests that both inputs can be
> >>>> connected. Unless they come from the same source always?
> >>>>  
> >>>
> >>> If you have a single ended input then only one pin (the positive one) will be
> >>> used. If the input signal is differential, then both pins will be used. So they  
> >>
> >> But the clocks describe input pins, at least in typical case, so that's
> >> my question: how many clock sources do you have here? One or two?
> >>  
> >>> are mutually exclusive... You either have single ended or a differential input.
> >>> And depending on the input type, the limit of the input frequency varies.  
> >>
> >> Based on this, this is the same clock, so using "diff" is not a property
> >> of "clocks". Look at other bindings how they encode differential choice
> >> for some signals - usually bool property, but not always - see other
> >> adi/admv devices.  
> > 
> > This approach that you suggest was implemented in patch series v1 (as boolean) / v3 (as enum).
> > Based on feedback in v3 received from Jonathan I switched to this. Should I revert it?  
> 
> I see:
> https://lore.kernel.org/lkml/20241220195220.1e1e1d6f@jic23-huawei/
> 
> I think that v3 was preferred with arguments above. You have one clock
> input and you want to configure the device differently, based on how
> this clock is wired. But it is still one clock.
> 
> Wait for Jonathan before reverting to v3.

This is following the approach we've previously used for crystal (xtal) vs clock
(typically one pin shared in those cases as well).

They are effectively different types of clock that might be connected.

e.g. adi,ad7173.yaml or adi,ad7192.yaml

I'm struggling to find the original discussion of that case.
Easy enough to find where they were added, but they mysteriously
just appear and I'm sure we had a detailed discussion prior to that.

I don't mind that much if we go to a boolean, the clock names just seems
cleaner to me as they are effectively different possible clock inputs
(with one shared pin). Whereas one of the pins is not shared as only applies
in the differential case.

Jonathan

> 
> Best regards,
> Krzysztof


