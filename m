Return-Path: <linux-pwm+bounces-9183-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CO1JFwcF2rw5AcAu9opvQ
	(envelope-from <linux-pwm+bounces-9183-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 18:31:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEB85E7C86
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 18:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C2C0300B8C1
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC11383C97;
	Wed, 27 May 2026 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P41/TPXz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2268428464
	for <linux-pwm@vger.kernel.org>; Wed, 27 May 2026 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898914; cv=none; b=ROr/Oo7YqFOUarNArZWC0Veehp3DbJI8zzj1ab7b4is4rJCvyrqlApukiq4X5PspT6aslyX4Ed9HIpbbRdU8jBVKsZSZ0MOKPjfx9Do0X/7T5WaDAadztktMG3fDcQQjtrEpWH4riTACHayaXsKJRFevn70rjCrtn8+lCCk/L8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898914; c=relaxed/simple;
	bh=zc/BrRX6BDzOZ1YxVqm6B33Dd86tu453/aG5x7by2Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmarE4cKtbZ1v+S1Vmwu9pSfu1vOzx8QQtx2iUYbq5OiWlpwrJ0vbbUZF96VAd0L/tHGjqcYZ9X4yNA95jHy4dr1/rx8Mgp2e9uEgHt0YczKrRAG1G1MKRWIIDUeoMCuixnqjzLtlrZC3s1Avxwg4KajTmcVT/I3X7pl6WCl2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P41/TPXz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5556D1F00ACF
	for <linux-pwm@vger.kernel.org>; Wed, 27 May 2026 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898913;
	bh=zc/BrRX6BDzOZ1YxVqm6B33Dd86tu453/aG5x7by2Ek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P41/TPXzjKCimocX2l+68xKVYLMQD2YFpgRnY8N95Jn9yNOi1yXTdaams4CJab49O
	 bX2ZaZys0qJ+rca4L6XTxpTwg2SW1F51yFoZOHDInvjFUOAaS2KPfgFRA1UvoLQgVX
	 On6byVttJQ3khgpcDI5UnvlOIls7rPsFiOc821kso1A1SJ+Wl0pHSqBjaVtn4Wl3tl
	 g8ySCprcy41UoQjBQYm0+IEky/9tU0P/cALgnmFxvT1zYK927Dk9PGxRd/B1Gt0W/n
	 zSn35gq7XfCyNMBEBmJOyVU1WPljsJ8qfpisHiRIHdJ0c+cLfQAGBnQgty7dyXDTwX
	 RUaLFUHeSe3jQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a858881ad2so14788499e87.3
        for <linux-pwm@vger.kernel.org>; Wed, 27 May 2026 09:21:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+BxzoC4oJc/vHh8E6oNZYM9JIon4b0fDnHMMCez1Fv7/p/6Hq8uIAnpW++DNb2ZRalwsEJkFFVcy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWzTzL0EKV44GjDNyqRU/15o6raVucSh4pLZHKepl3TqRuubCl
	vlaGCnxw6HqcWOz6lH9pTARC8AKe4+w3eqOs+ywCDjlIxo5NrrqgU3ZybNFAmBPuTeWx5bwwJNq
	dRLzu0Sl3Z4XAg/TsdHVzXX2ekwZ2H54=
X-Received: by 2002:a05:6512:2201:b0:5a8:86a6:c476 with SMTP id
 2adb3069b0e04-5aa323843dcmr6639602e87.37.1779898912083; Wed, 27 May 2026
 09:21:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523173251.72540-1-manishbaing2789@gmail.com> <20260523173251.72540-2-manishbaing2789@gmail.com>
In-Reply-To: <20260523173251.72540-2-manishbaing2789@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 27 May 2026 18:21:39 +0200
X-Gmail-Original-Message-ID: <CAD++jL=5GoXqgRCmH=f1btY3eToi3_wMBJEarohJuZhyKxowJg@mail.gmail.com>
X-Gm-Features: AVHnY4JfnnRkXYHTThwWUKLSwG3QzP6v1BK1Sk1xyc9ylqzeUPifpk0-WhZKh-8
Message-ID: <CAD++jL=5GoXqgRCmH=f1btY3eToi3_wMBJEarohJuZhyKxowJg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: mfd: st,stmpe: Add missing properties
 for PWM subnode
To: Manish Baing <manishbaing2789@gmail.com>
Cc: lee@kernel.org, ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9183-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,microchip.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8EEB85E7C86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 7:33=E2=80=AFPM Manish Baing <manishbaing2789@gmail=
.com> wrote:

> The st,stmpe-pwm binding is already covered by the MFD schema in
> Documentation/devicetree/bindings/mfd/st,stmpe.yaml. However, the
> PWM subnode was missing a 'required' properties block. This allowed
> Device Tree nodes to pass validation even if the 'compatible'
> string was omitted. This omission could lead to probe failures
> at runtime.
>
> Fix the schema by adding the missing 'required' block.
>
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

