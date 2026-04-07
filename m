Return-Path: <linux-pwm+bounces-8516-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAUoL1Iu1Wli1wcAu9opvQ
	(envelope-from <linux-pwm+bounces-8516-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:18:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 653103B1ACF
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BA0030628CD
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 16:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5502534A76B;
	Tue,  7 Apr 2026 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNUbY+H5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590BD391E45;
	Tue,  7 Apr 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578207; cv=none; b=C6R4CoNCPBZrQhiqfamJtsz6oWwNZ6eoWMyJpPyddq2l43l4l1qgj9cLznLUDHO2i/nsFe5Imscn8/Ti485RLkxzck3znbJyvWWwJN3RVxa1VV9NEey3PwzQG5cbm1LgY4ND984916Zz+3P2zipGCEi1NvKmS6aQN/zdSv4QmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578207; c=relaxed/simple;
	bh=+LzdHSeVHiMH4ZZcTEUvseGkknSG0WWsqny03v1gLto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsSH3xhF0egHAEZL5Vbg34NCj458qzczm7eCwRqIQO1P/VwygffIpEVWP2Zh5AaOHmH9VepfcQAzELQTHcq6XtUBDpnLIF/u1KmcpTMjN2ULK7fUN0NKogO6QxjQffVfSodC6Y6E+ABu09zc7gTbnzsgonwynYBpYA56hY11OHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNUbY+H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67838C116C6;
	Tue,  7 Apr 2026 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578205;
	bh=+LzdHSeVHiMH4ZZcTEUvseGkknSG0WWsqny03v1gLto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNUbY+H53sWRWGY+ZkRJU0Pngf2NVkOSP1tMr1Fht6gdcC9vtciJYT6kEcS5ZXTcK
	 aaCdOc/QX/dmIWkNcaGmy9F6iR4TJ8GqO2UTNlakS6NwKu68o716Enl2CRClzOPvXa
	 z9SwM3QZ7eZpCcdE46XlhpLz8yjevDOAl9lwR0iRhaN0YhKlU59PbHiDT1PnoRMJYP
	 bnwTU0Yr7LV6LkcIAROPhjOpCFMuv3SKZW2E2IG3QD1Y8HzJasypv7/7kiewMJ51v7
	 Tnoij7H3XA3707V/hILVc4egCWKZ8MtubR0p5y5/6c5yv0qlsdrbKRYJIMBEwsI6uo
	 AIHAoBwN39D4A==
Date: Tue, 7 Apr 2026 11:10:03 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, Guenter Roeck <linux@roeck-us.net>,
	Neal Gompa <neal@gompa.dev>, Andi Shyti <andi.shyti@kernel.org>,
	linux-gpio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sven Peter <sven@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 8/9] dt-bindings: arm: apple: Add M3 based devices
Message-ID: <177557820303.2666031.1709190779045353584.robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-8-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-8-5842e1e393a8@jannau.net>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linux-watchdog.org,lists.infradead.org,lists.linux.dev,roeck-us.net,gompa.dev,openbsd.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-8516-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jannau.net:email]
X-Rspamd-Queue-Id: 653103B1ACF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 20 Mar 2026 13:23:26 +0100, Janne Grunau wrote:
> The Apple devices with the t8122 SoC (M3) are very similar to their M1
> and M2 predecessors.
> Only the 13-inch Macbook Pro is replaced by a 14-inch version based on
> the design of the 14-inch Macbook Pro with (M1/M2 Pro/Max). The Mac mini
> was not offered with M3.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/arm/apple.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


