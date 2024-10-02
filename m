Return-Path: <linux-pwm+bounces-3430-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3A498CFFB
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 11:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774541C2124F
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2024 09:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3968198A0C;
	Wed,  2 Oct 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="QuJwwvjC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zj8iDjWg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254AE84A52;
	Wed,  2 Oct 2024 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861042; cv=none; b=VlakwSfLwip3Av8ehvWHx+MlxSQsqqpFOwL0HpNKCy4f6iNSLmVRgXuLTQ/IoWONKZ0+LlWGzQrYn6qse7GzzEp7Q0ZzUB4blpQCqjtP6Vq0uUydAmSskVn9SFH/epqFtJ/mCvrRRsAg5ji5BwN5QdQv32+9QlIVymWnZCRkETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861042; c=relaxed/simple;
	bh=AAYI3Gt+D9Cgzx0LmTcoxOcLDnJz9sHzdQg9tl29d8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGWdi6BBpMSYNJriHC8OcYRMDsWWIs7m+be1ASvrcWrWl6senGp3OuDllXih7NNP2u3ZEK5C+aorjZMmJiyVyMpClZeRWVdpF0acN0a6Wi8LskDjNq8s7sDjHe9kZqOCnuXILMDx8P3YrvxqpYoE1C5bCJR0OO1eHanuePBSYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=QuJwwvjC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zj8iDjWg; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id E8846200A49;
	Wed,  2 Oct 2024 05:23:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 02 Oct 2024 05:23:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727861038;
	 x=1727868238; bh=1wPBV2CtAfCxsHt6vXI1u7/VDJf3lNbwZEi9inaErLs=; b=
	QuJwwvjCXMBstSyTt2ibEcamIo2+Gkt90Ah/ZbVHiRDstxzJJXbaBPREgIPVQtDu
	2IQiferN53Cm6St7whHPmdOCIlFeTyrYcZh/Jq5IaR4X2z0nLmCCK2vvAbrFN9rt
	lT/tFrFbm+KWuL247BtXQUEfIGOPGehSxO+9/ABynpifTYx+GAksIzfxFLCQ54R1
	s5QxcZ2/UqX2aXxtCNwx4tq6XiUlKOTGLG+BOT4jkGtCdhQbyX2DsgpgmxSpF/Ve
	QAKm1uce+DWccvFZOglfv8Ox/9gYmH4BTuJzVG9yK+UiPTcNGfGvVt5tVhSSd0e8
	B7Ekv3pmNSUowCLWbXl46A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727861038; x=
	1727868238; bh=1wPBV2CtAfCxsHt6vXI1u7/VDJf3lNbwZEi9inaErLs=; b=Z
	j8iDjWgaTEBk3vDijGRlGTVogBTQiUXXfbABiYMbBTTwj53/TxFN6jMfBAjEpT0b
	3Lo4uFHvEZwkNx00/qRGgjmM2pDH4DCzosU7CI7FDnVbtKCEUi6F5hmwD0DqLY5L
	U7/OTcXTNl3aV9mcgutaovqICSjQv0nHnZP0CKfDwceqJo0YX5BpcgWmkgDeyfod
	KSTzeTNoiyddV08Tom4/QXVInro66UeWqW0yjiUAJtF+ZVFGZbRNpCcp5qJ+pF/O
	5rX5MIpFo6tEi9gmu4xvqdbtcGa7Iv/O+uSvcoxbjI1/abVZDhLPwGhZRpKzZ9cI
	qVGJK+VbypI97CYT/ArJw==
X-ME-Sender: <xms:LRH9Zsk_WXCJbPDRc2vNMGPlguniQZhgwM-wdwKir_XUfkd0zKe-Uw>
    <xme:LRH9Zr3akGgxBjqqxq3WB0wyBxE2Y4Xru-zWIcrO-2kxO6nmcGOMy9asyMHh6TAif
    aviRRCyts7heQ>
X-ME-Received: <xmr:LRH9ZqpIzy1iQYkrdNhrVZ-Nq_saUdDrSpOUkyPCIlq6QbFdVss64OeuNNPkw6g1qGyhL9gosugMwpIFHtjUaFCdl98zqbJ28fgkoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeehfffftdehkeevfeeujeduhefggfetffeijefgkeelffdtjeefhedt
    tdfffeffueenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhdpnhgspghrtghpthhtohepgedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmrghrkhhushdrvghlfhhrihhnghesfigvsgdruggvpdhrtghpthhtoheplhgrnhiirghn
    ohdrrghlvgigsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvhhguihdrughjrghith
    essghoohhtlhhinhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhs
    rdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphifmhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmh
    gvnhhtvggvsheslhhishhtshdrlhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgt
    phhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnh
    hivghlsehffhiflhhlrdgthh
X-ME-Proxy: <xmx:LRH9ZokYJmotGcGhC28P1JQ0SfIfGOhWrLJ4ei_uog9Hep3W-u2ZVA>
    <xmx:LRH9Zq1M0xTfph_85-Qn3YiyB140f5sId7AuT9Atf4uE0fREMzbOHQ>
    <xmx:LRH9ZvuvPeu2RSpNdmtow7zR36WzX-imbT-NLcyUAbF6GvPvpMicFA>
    <xmx:LRH9ZmUBYe0IbYVvg1kRfj_5jZOkQEHBGaO113FTK9qTPjORkr3QcQ>
    <xmx:LhH9ZgVnyXxYwMI2ap2i61BR4vYQUGzIXKqLe69Xv4COkBz9kONmCKLb>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 05:23:56 -0400 (EDT)
Date: Wed, 2 Oct 2024 11:23:54 +0200
From: Greg KH <greg@kroah.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Mehdi Djait <mehdi.djait@bootlin.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v8 2/2] drm/tiny: Add driver for Sharp Memory LCD
Message-ID: <2024100246-gladly-overfed-75b9@gregkh>
References: <20241002033807.682177-3-lanzano.alex@gmail.com>
 <b671e4d2-e969-4b9a-a7ff-b3b688689ee8@web.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b671e4d2-e969-4b9a-a7ff-b3b688689ee8@web.de>

On Wed, Oct 02, 2024 at 10:56:42AM +0200, Markus Elfring wrote:
> …
> > +++ b/drivers/gpu/drm/tiny/sharp-memory.c
> > @@ -0,0 +1,681 @@
> …
> > +static int sharp_memory_maintain_display(struct sharp_memory_device *smd)
> > +{
> …
> > +	u8 *tx_buffer = smd->tx_buffer;
> > +
> > +	mutex_lock(&smd->tx_mutex);
> …
> > +	mutex_unlock(&smd->tx_mutex);
> > +
> > +	return ret;
> > +}
> …
> 
> Will development interests grow for the application of a statement
> like “guard(mutex)(&smd->tx_mutex);”?
> https://elixir.bootlin.com/linux/v6.12-rc1/source/include/linux/mutex.h#L201


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

