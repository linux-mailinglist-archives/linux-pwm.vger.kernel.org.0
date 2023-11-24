Return-Path: <linux-pwm+bounces-180-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6727F6E53
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 09:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB401C20D02
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 08:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6C6A34;
	Fri, 24 Nov 2023 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="bArYF0fm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072121BD;
	Fri, 24 Nov 2023 00:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1700815072; bh=1Mwv2mZ4G1zj1lW5F8OtJV8zDYDCDU5W1iiA610TS+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bArYF0fmeSCcuvIHjsf+Evh/Hm1Kzv6ZSluQtPGq8m7E/HroOIxpfsKiphaoHS5zP
	 pscsNp2UvjO+VRWWEJiKLiIWGF10OJokcKR5tMbK5z4/+aV5sXInIEq4q98Kv2JLbu
	 t1xp3QdP8MdDvyf6mjeUwuW3lECd5s4cqFNuZVdCpZDYaTpEz3VNWuZSeHV0x5tQcx
	 Dv0OOgfq1ez4uH+GDMeI4vrLpD1yZCyDfa/uMFr5ST8HsXZKiUCSczo/0gePhK/i+S
	 ekvXm7tZIwwX73GdoFwoOQh5DlvlAtsBrtDSFPFWEgASRBulHkMqSMAbXmyyLJvmX7
	 NUDpVb7EtCjxg==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 985451000CD; Fri, 24 Nov 2023 08:37:52 +0000 (GMT)
Date: Fri, 24 Nov 2023 08:37:52 +0000
From: Sean Young <sean@mess.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5 0/4] Improve pwm-ir-tx precision
Message-ID: <ZWBg4OZL-pW4K-iv@gofer.mess.org>
References: <cover.1700323916.git.sean@mess.org>
 <ZV3BJ67_JCpTYEMl@gofer.mess.org>
 <20231123165842.ubmhifvtqd7g6jy6@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123165842.ubmhifvtqd7g6jy6@pengutronix.de>

Hello,

On Thu, Nov 23, 2023 at 05:58:42PM +0100, Uwe Kleine-König wrote:
> On Wed, Nov 22, 2023 at 08:51:51AM +0000, Sean Young wrote:
> > On Sat, Nov 18, 2023 at 04:16:16PM +0000, Sean Young wrote:
> > > The pwm-ir-tx driver has to turn the pwm signal on and off, and suffers
> > > from delays as this is done in process context. Make this work in atomic
> > > context.
> > 
> > Hi Uwe,
> > 
> > Do you have any comments on this series?
> > 
> > I hope you don't dislike the pwm_apply_atomic()/pwm_apply_cansleep(), I am
> > not wedded to this name, it's just me reading the room and thinking that
> > would be the most acceptable to everyone - I may have misread this.
> > 
> > Thank you for any feedback
> 
> I didn't find much time to look into it. Skimming over it, I like it.
> I'll take a deeper look soon.

Great, thanks! No rush just wanted to make sure it wasn't forgotten.


Sean

