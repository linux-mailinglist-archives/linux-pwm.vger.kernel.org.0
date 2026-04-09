Return-Path: <linux-pwm+bounces-8528-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPXhLB1j12nvNQgAu9opvQ
	(envelope-from <linux-pwm+bounces-8528-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 10:28:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BC23C7C38
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Apr 2026 10:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5489300DDD7
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2026 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B746D3A5453;
	Thu,  9 Apr 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFmWyjvj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5D3A4F54
	for <linux-pwm@vger.kernel.org>; Thu,  9 Apr 2026 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723286; cv=none; b=KHsbcbLDjEz58vUAQY3UcvwV4rqcAJvc130ZPNOVM/Mjixe5vW6mZaEcyEd9KVNT4MftWhBgEMKsDLieDhptCyqVOpt/0Mu2lROoAYcZv9hhwtjFzf7rA5h1agKGtLspJNHw0S0+gbl5I/NBea9fiA6iOviYPb1j4gqistdSYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723286; c=relaxed/simple;
	bh=aTaUCr1A2I+1wqTvl3TKv6QTLEetojWJo60VzPZFc+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqmEz6KXgQMsZZoB3RzIGW3nC9FvqCEW1m3k2scYqsF40f35IuH4LlokoXU4dKABgaDj8e7IfA5s6pymhB1vMSMQItuCz6ZeR0Ck+rFmL3C4z7c+SAfxF/htMZoqrvw9WPNtfJLoT458mNGR7svXa1ogssvRqwjv0smHxg7H5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFmWyjvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D264C19424
	for <linux-pwm@vger.kernel.org>; Thu,  9 Apr 2026 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775723286;
	bh=aTaUCr1A2I+1wqTvl3TKv6QTLEetojWJo60VzPZFc+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hFmWyjvjjainN0waFI5SgxxVEcVbJNwNrL0mx+XuPVAsRyyMkxghRurUAIU+4uiOf
	 fXljosaAod1JlDrJMGbseZ9MuWHidtbqP+d6gC5EYv2oJ8BKH0kdy/rebKAbU0ShkJ
	 ANEHl4nDw5Wfvrm27lOHVgA84IclOfaZ7z5Wr5XkxQtFCNzpbRADM9pBYskD/2rVQh
	 RV7WryA3gluS5oyR8WvDWPPq0YicpANCGngJcqdFAOAd3bVB4Po+JJse43tdThFCEj
	 23BvfTpLx0m7cN62ig1JkvJJZTB+ysqsXcPoVJnTO7lWAiOOhqrW7PQCrE9fP7ptz2
	 VJhgVubw101hA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79853c0f5b9so7585477b3.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Apr 2026 01:28:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5p4reKKQU63AIQCLehRXM3Lyp/tXClNMtT5XUz85BMJsdtaI7rCSqtP7N8U0m3kOFjPDpb3XpPtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+UkusyrY3CDBK142oyAAGa64flcBYUG4gECr9ZJiH8sGmORn
	qqDHWfEgFErEttD6QX3/L8f8YWxNPdjZP2Bd9YJJcnAeqnhU+3jAMinugsz/rOE6Tp46g9zALZa
	MG0dWLlGnjeyC2cDWSpEtpyzLYcHyhJU=
X-Received: by 2002:a05:690c:86:b0:79f:b903:88be with SMTP id
 00721157ae682-7adf1f63befmr26878747b3.16.1775723285630; Thu, 09 Apr 2026
 01:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 9 Apr 2026 10:27:54 +0200
X-Gmail-Original-Message-ID: <CAD++jLkcoSyt4ag=Vtf0HW+UhnvXAQH=RqdiZ0LB17UdURjTCg@mail.gmail.com>
X-Gm-Features: AQROBzCBPK9j1p1wyGlpXng0vuJPY67DBxyZqUb3UmeFzFxdcTXTQHWBijmLSC0
Message-ID: <CAD++jLkcoSyt4ag=Vtf0HW+UhnvXAQH=RqdiZ0LB17UdURjTCg@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8122 compatible
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8528-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,jannau.net:email]
X-Rspamd-Queue-Id: 52BC23C7C38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 1:23=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> The pin controller on the Apple silicon t8122 (M3) SoC is compatible
> with the existing driver. Add "apple,t8122-pinctrl" as SoC specific
> compatible under "apple,t8103-pinctrl" used by the driver.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

This patch applied to the pinctrl tree for v7.1.

Yours,
Linus Walleij

