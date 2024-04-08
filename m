Return-Path: <linux-pwm+bounces-1876-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE189C929
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Apr 2024 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C0B1F2527C
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Apr 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4384A140E4F;
	Mon,  8 Apr 2024 15:57:57 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54322091
	for <linux-pwm@vger.kernel.org>; Mon,  8 Apr 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591877; cv=none; b=qawlAt7Z6jlRjffNgMKUPMP5Ss5yqO6CSGlhGXnYZedS8Lh5rNBBFOyFfprz1JGw9keEHqeMHTESbNCYUNibgPvOBwA9d825bToF4UrO7snmePsgzKTaAB+wdAn/Jz5MJaXTv1oDTKB44wiFzhTZJWvLahJUWR7vorR61lh/Lxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591877; c=relaxed/simple;
	bh=PKIDhUpsciv1VHDx4PmJR8ITrW2ofu4TSSUWRKaylK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mTq6RCj3fzpNQELuzfAQ5hXzoZbXJWRGxXPQnEnxQGyFijyc2XX6K3ytTKpiCF/5zmIk+KLRymL5IxdrVt6lGWcTTulqIUOB2U1inAar13EdhFzFU6p2wZ8qpQeKGRubRWVqpmQgffjEL5bKBDKeYKOotUIYFGFzkaiBQwovx+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 8 Apr
 2024 17:42:40 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.037; Mon, 8 Apr 2024 17:42:39 +0200
From: John Ernberg <john.ernberg@actia.se>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, John Ernberg
	<john.ernberg@actia.se>
Subject: Re: [PATCH 8/8] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Thread-Topic: [PATCH 8/8] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Thread-Index: AQHaictjh2dhWToPm0mPNkeTSyNMRw==
Date: Mon, 8 Apr 2024 15:42:39 +0000
Message-ID: <20240408154233.890293-1-john.ernberg@actia.se>
References: <8d3acfc431ecd431d6cced032dcb58ad2579474c.1710670958.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <8d3acfc431ecd431d6cced032dcb58ad2579474c.1710670958.git.u.kleine-koenig@pengutronix.de>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.44.0
x-esetresult: clean, is OK
x-esetid: 37303A2958D72954657C6A
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Uwe,

Seeing this patch set made me excited.

Did you consider or try a pwm_line model structure, that is connected to a =
file
descriptor, more like request_line from gpio chardevs?

We have been using gpio chardevs for a while and really benefitted from tha=
t
over the sysfs interface. I wrote a simple wrapper around the PWM sysfs
interface mimicing the way gpio chardevs work for PWM using dirfd, to make =
our
application design more streamlined.

With this patch set I do not see how we can name the PWMs in the device tre=
e
nor during request which is a big benefit with GPIO when we need to support
multiple hardwares. Nor can I see how we would inspect which pins are
allocated or their names when debugging.

Thanks! // John Ernberg=

