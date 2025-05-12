Return-Path: <linux-pwm+bounces-5892-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8FAB314D
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 10:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B03171241
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027A719CC28;
	Mon, 12 May 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="TiL8AUVu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XIlx7pkU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F42AEE1;
	Mon, 12 May 2025 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747037774; cv=none; b=C3MTyBzOCvpjmFeFkqBx4nUG18N0jeDjz72wtB1i2+kEwl6n2A0CtQUtjDlHHrCvIlD1Wzr2sGIsEQDxZiAMi5mQ2ctLPBQZU5cUqwvzcvXotEyeFIyfp4Z6DdR6Wk31DDO9++MG8QhXwnwQDafT9yZlEUxE8jYYxuPQg0DDMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747037774; c=relaxed/simple;
	bh=rcg9bJMMhinaI0GIkoE2adqh+f9JOnlmHWaDSvylKzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/pt9aSS/taQKiNMSidCa/9J9v4VINaTlE6aSIO7LEIo5Eftwjh7+Q0kt/QiSuvi0AahupqFkAsnWhzvYv61u5T+hfmUejqfEgiZJON9h1xKiu52XUX6GCpl6CE3cq+6ecyF+Vb+HjG+Uo6BPs7nnjwZXHjVEOCJ5If4x26MjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=TiL8AUVu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XIlx7pkU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 511B2138010C;
	Mon, 12 May 2025 04:16:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 12 May 2025 04:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1747037771;
	 x=1747124171; bh=a3oo7vWvcwXTglAybjCSGMarjhHOibqoiFfQAskz9tM=; b=
	TiL8AUVuC65RfMzvsNEW5x3cL1mriS4jKy1xWnDPQsV0zpBwkVkqhNJMc1VdTA1x
	ytvdrT+JLPi7Wb/SZGAIGUdQO6tagmNDXJvU0gztT4GW5odhwiSrZdKhkfSSwc6j
	BKfK85Le6LmFO9jKDuDZjZVZjdrtxbM5ka2ksavBC3OnFhQaCfFu7a0O0WqsD9lz
	8N6hIrhIfyLq64RPlU3VNCWqbG83JgEbM+BSTS3z2oGV7Sw0tS53/vzZnzfFpfPr
	oG7AB/ZmwlP/s7yvhDihy4Bqci0O2IfGTIq+DONZMpF129pX2AAxiwGW67XQa4W+
	t1lHwgCo3PWEvzTywhNV3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747037771; x=
	1747124171; bh=a3oo7vWvcwXTglAybjCSGMarjhHOibqoiFfQAskz9tM=; b=X
	Ilx7pkURgSZi7sS/ZUOoaEl1NomKOHyS/chcKpBOhfImX5V+Bd70hnKqR9jl8j0H
	lmO1x6jVI2rPpg4TSCnVkPB7yIqY+sIJ7K+BNdkxFROvR4J9yS86rEWCPil9LPmP
	7iYJgiOEo/J29aE1dTaEr7dPbawDbSHdGJm4ALrU1golgdNf8uiAp1f5NPh+Ml4w
	t3UZ+SQSZROW/xB/gd71UX5x9RyTC7NS3vf8oGlZA+sGCKeDWcsglguh1+iPDlyt
	AdS1bO9DdIoknIN7P0QJ8+LCzlubjEnSMT1habXvmK3Ry9dP5m+Tqlil9fVWZZbC
	Nk2rv4mVl52puNDKd8F/A==
X-ME-Sender: <xms:Sq4haPwnaGw_-L4PsrbKwQ00AtKemmnWmVazAPKmlhPKo6whD5QyTw>
    <xme:Sq4haHSKi2iuI_cQ8-Ld8k018iGN48-iMRzB_9Ip3H_8Ib26r9_vfEYuKnf1l4hyR
    gY1SW1l_qD20p0eOwI>
X-ME-Received: <xmr:Sq4haJWDHhS1_Pa-J7KZmx_9NP3jUa4M_sCwskPWEUeTrKcQY7Kax7W2YeOrfCBoGjX2mhfOXd28veyysHuUo3Nnt2q8_XMWWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefpihhklhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrsh
    houggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeev
    teegtddvvdfhtdekgefhfeefheetheekkeegfeejudeiudeuleegtdehkeekteenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdr
    shhouggvrhhluhhnugesrhgrghhnrghtvggthhdrshgvpdhnsggprhgtphhtthhopeelpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhunhhinhhorhhirdhmohhrihhmohhtohdrghigsehrvg
    hnvghsrghsrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghr
    mhdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsg
    gvpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphht
    thhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphifmh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrvghnvghs
    rghsqdhsohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghijhhurd
    gurghsrdhjiiessghprdhrvghnvghsrghsrdgtohhm
X-ME-Proxy: <xmx:Sq4haJhQdcP7Dyr3cOEHyWWWNH1h8MKRxm2KpnEDlz0uoPtGb1yesg>
    <xmx:Sq4haBClv_eht_zi5DWBgACAQmsuCnrlF4N4I6XeHFjwsfvvopgoCA>
    <xmx:Sq4haCJEjDabN4kETVKGASbVaWUtrOVNqdaSQ8KsuhkkxpkE04qZRA>
    <xmx:Sq4haAAg5fzJquGcrXGFQ_m6fvopRJEN9jo3DtTuBheBKS_FKpguqA>
    <xmx:S64haNWvgKMznWWjGAZ9pT_cxjnNaCksgpg3O8fiW6CSNJxh11pYbo2g>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 04:16:09 -0400 (EDT)
Date: Mon, 12 May 2025 10:16:08 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: =?utf-8?Q?=22Uwe_Kleine-K=C3=B6nig=22?= <ukleinek@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v4] pwm: tidyup PWM menu for Renesas
Message-ID: <20250512081608.GD2365307@ragnatech.se>
References: <877c2mxrrr.wl-kuninori.morimoto.gx@renesas.com>
 <20250512073949.GC2365307@ragnatech.se>
 <i4b7c3afvksave2uswfnma2d3mhezefec7t5qhxzikfdsey4tx@wmszr4dtqkr7>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <i4b7c3afvksave2uswfnma2d3mhezefec7t5qhxzikfdsey4tx@wmszr4dtqkr7>

On 2025-05-12 10:09:17 +0200, "Uwe Kleine-König" wrote:
> On Mon, May 12, 2025 at 09:39:49AM +0200, Niklas Söderlund wrote:
> > Hi Morimoto-san,
> > 
> > I like cleanup patches!
> > 
> > On 2025-05-12 06:33:12 +0000, Kuninori Morimoto wrote:
> > > Because current PWM Kconfig is sorting by symbol name,
> > > it looks strange ordering in menuconfig.
> > > 
> > > =>	[ ]   Renesas R-Car PWM support
> > > =>	[ ]   Renesas TPU PWM support
> > > 	[ ]   Rockchip PWM support
> > > =>	[ ]   Renesas RZ/G2L General PWM Timer support
> > > =>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support
> > > 
> > > Let's use common CONFIG_PWM_RENESAS_xxx symbol name for Renesas,
> > > and sort it.
> > 
> > I think you also need to update the symbol names in the various config 
> > files found in tree. A quick look,
> > 
> >     $ git grep CONFIG_PWM_RCAR -- arch
> >     arch/arm/configs/multi_v7_defconfig:1206:CONFIG_PWM_RCAR=m
> >     arch/arm/configs/shmobile_defconfig:220:CONFIG_PWM_RCAR=y
> >     arch/arm64/configs/defconfig:1553:CONFIG_PWM_RCAR=m
> > 
> >     $ git grep CONFIG_PWM_RZG2L_GPT -- arch
> >     arch/arm64/configs/defconfig:1534:CONFIG_PWM_RZG2L_GPT=m
> > 
> >     $ git grep CONFIG_PWM_RZ_MTU3 -- arch
> >     arch/arm64/configs/defconfig:1556:CONFIG_PWM_RZ_MTU3=m
> > 
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > v3 -> v4
> > > 	- Based on linux-next/master
> > > 
> > >  arch/arm/configs/multi_v7_defconfig |  2 +-
> > >  arch/arm/configs/shmobile_defconfig |  2 +-
> > >  arch/arm64/configs/defconfig        |  6 ++--
> 
> I didn't check in detail, but looking at the diffstat I'd claim that
> adapting the defconfigs is coped for?

You are correct, my bad. Had the wrong branch when testing. Sorry for the 
noise.

> 
> Best regards
> Uwe



-- 
Kind Regards,
Niklas Söderlund

