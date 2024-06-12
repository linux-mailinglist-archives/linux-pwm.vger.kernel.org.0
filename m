Return-Path: <linux-pwm+bounces-2437-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A357905046
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2024 12:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2BC1C20E70
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2024 10:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C27216E893;
	Wed, 12 Jun 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="nAExHd22";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="s1YeLXkz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailrelay1-1.pub.mailoutpod3-cph3.one.com (mailrelay1-1.pub.mailoutpod3-cph3.one.com [46.30.211.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7009316E888
	for <linux-pwm@vger.kernel.org>; Wed, 12 Jun 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718187556; cv=none; b=KRfpy6aAgOFE2ggyXW5IUFIZ+3Y0zElHp/lmyIAhpIGugvQQnOce1D/IdZJT3S7dfCvB3ekQntQO1kwoArFyxspzvgioChGM61ZGbGobzyNHckJfrrYGFU/H9Q3r/LEXDKrf1FG3WKofdsHy3MIbpsVtAoJa1iXRMphYjLTfC0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718187556; c=relaxed/simple;
	bh=ovNo9GtRTlkwlssn/HiOD9hpv7sqkXelq8K9GlKM2ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRM0b2cVuGlkkDYHPPi7ZnblvHh14DddSAa2B1kEZS2So0SieZKer+7CAM5kJapeBe7y94RTAR4W5OgOuP//tkwe9Badt1xW2enQf76CmIWLPUsghThr2lcOac1wZNyq13dq9aEnryrpJg5iTHxNu6Q9iIYUpox1kZQNRePV0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=nAExHd22; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=s1YeLXkz; arc=none smtp.client-ip=46.30.211.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
	 message-id:subject:cc:to:from:date:from;
	bh=af9tXlANVtlQwBmD+QdoVRddc7MbwnrlvWQxh4+FXXs=;
	b=nAExHd22AYzTdymX0eFUsjJ2mlWPhKSOdWtU0yVqH2bU9ovLQRKQeZhur+KfJ9CFef2wWc47Eb1wg
	 woOvVerA19jBz+5gvLQEOBBtyke7o+GbIukjEuM3ZFXjpkaEcRfRSsbO5e2Apkledi0IcxtO6RpbyB
	 QVjxpoYsI2Mh4yHhhzdKehjFYvAnjtfAP07u/G3JZzmhsgldRIlHn08Vj/yKZWjbyDzIlv0Ue+38LA
	 H1SDzlwLvEI6KctWEaonN+QYNeUO17NX70Vm9iAfNb2NuWGsn5OsIsUE2DLVUcKwgDKX5Hlwd21HQ7
	 7c4aw7cmCTxMos5o7CTNRG41oGsfTmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
	 message-id:subject:cc:to:from:date:from;
	bh=af9tXlANVtlQwBmD+QdoVRddc7MbwnrlvWQxh4+FXXs=;
	b=s1YeLXkzSJLX/9K3+GaWebedmZYs8udZAJgDQJzsM/hyEHA4ts5BOcNk1YM3j2Pq+9DSbxCaHCu5j
	 +qO1afiCQ==
X-HalOne-ID: 0c327bce-28a5-11ef-a645-bf3d7f4c9d3b
Received: from ravnborg.org (2-105-16-150-cable.dk.customer.tdc.net [2.105.16.150])
	by mailrelay1.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 0c327bce-28a5-11ef-a645-bf3d7f4c9d3b;
	Wed, 12 Jun 2024 10:18:03 +0000 (UTC)
Date: Wed, 12 Jun 2024 12:18:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, linus.walleij@linaro.org, f.suligoi@asem.it,
	ukleinek@kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/17] backlight: Add BL_CORE_ constants for power states
Message-ID: <20240612101802.GA595554@ravnborg.org>
References: <20240611125321.6927-1-tzimmermann@suse.de>
 <20240611125321.6927-2-tzimmermann@suse.de>
 <20240611175544.GC545417@ravnborg.org>
 <736884a4-8077-422d-8877-6ac4af58a85b@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <736884a4-8077-422d-8877-6ac4af58a85b@suse.de>

Hi Thomas,

On Wed, Jun 12, 2024 at 09:26:11AM +0200, Thomas Zimmermann wrote:
> Hi Sam,
> 
> long time no see.

Had some spare time between jobs, started on my new job last week.
Time will tell if there will be energy and time for hobby stuff.

> > 
> > On top of this - many users of the power states could benefit using the
> > backlight_enable()/backlight_disable() helpers, but that's another story.
> 
> Should I attempt to fix that? Many drivers appear to do something like
> 
>   props.brightness = ...
>   props.power = UNBLANK
>   backlight_update_status()
> 
> That's the same pattern as in backlight_enable().

I would keep the changes at a minimum, hoping someone else jumps in and
do the cleanup. Then you can keep the patches that remove the fbdev
dependency simple and easy to review (and thus get applied).
Maybe the obvious places, and do the simple replacement for the rest..

The drivers initialize and use the backlight properties in interesting
ways so that would require a bit more effort to implement and review.

I did it once for most of drm - but it was buggy so I ended up scrapping
the patches :-(

	Sam

