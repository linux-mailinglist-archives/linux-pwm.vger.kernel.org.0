Return-Path: <linux-pwm+bounces-8932-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCihFIy1CWqomAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8932-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:33:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24D8560F76
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 14:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09273300A8F5
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2026 12:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAF136212D;
	Sun, 17 May 2026 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbV1TKBs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07380288505;
	Sun, 17 May 2026 12:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021190; cv=none; b=qnb+nbfQ5/9SVcN9vT74OUXsML9ohATXE5yWFpr6tcKzEkd8pSZFGkyHmX1pe41v4x+EeS5Vkg4C8EhI63JYYI98eyoYPBTgaLrr16ARJRic+ctoq/3Hgt0V+/1JRnWGKHeV2tcEcY8l5WI6hJxTkcbedSD73elsQ5G3NAQQiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021190; c=relaxed/simple;
	bh=GWLg1MwaJuT6FxnQTSl9CM6MfpL41cD4qEr5UVrr6Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J8B2ifrNy1YdV4omBXqFrYOTdx8CPQib6yIOEYMVnfx7mpNIQ5+IaqnrITnj7RL+RSq+Jpm+79/LF8k7pJGWZwfxXRlK9at2PIFnoHcg5F1qWEty5a0H54hegh16Fxc92+DC+x900k79gMD7WNvTe7KvGcU/RJovcZwsNC202aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbV1TKBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB77C2BCB0;
	Sun, 17 May 2026 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779021189;
	bh=GWLg1MwaJuT6FxnQTSl9CM6MfpL41cD4qEr5UVrr6Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZbV1TKBsOsHLJ0uOYkfw/yYndYuODuQjt+WR5oIPfljcBWFku939x6AjiYvHbwbRC
	 szJs6smdUYHkgYabV/ToHPsxr7HGVHkpczFqH+1HnRF8dzD3+Q4QCVJLCLt+tYos2+
	 tX4SVk4K3rSB1w8do+Zmf1l6iz/aMMQBtsD/C2ku6/TMtOIHDcDe3dXxlb+ZacfPUr
	 +yzi0qnPuGt8wZUhnx+DVl/8flD3LbSW1SLLPXsSsyoNwLlht++IyLDJ5CAybrRca6
	 Pq+8SCEJoHDpKFXcVg9ZWt/JWScghPxQtFx10VHMO4UOti4RE2OjgD3h/g+ajZ7t7z
	 pC+xwUuq4GCNQ==
Date: Sun, 17 May 2026 13:32:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v11 6/6] docs: iio: adc: ad4691: add driver
 documentation
Message-ID: <20260517133257.4c56a7f0@jic23-huawei>
In-Reply-To: <78d4bb1c-4c6d-4781-86ee-458579ac6990@baylibre.com>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-6-eab27d852ac2@analog.com>
	<78d4bb1c-4c6d-4781-86ee-458579ac6990@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A24D8560F76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8932-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Action: no action

On Sat, 16 May 2026 13:18:03 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/15/26 8:31 AM, Radu Sabau via B4 Relay wrote:
> > From: Radu Sabau <radu.sabau@analog.com>
> > 
> > Add RST documentation for the AD4691 family ADC driver covering
> > supported devices, IIO channels, operating modes, oversampling,
> > reference voltage, LDO supply, reset, GP pins, SPI offload support,
> > and buffer data format.
> > 
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
FWIW I finished giving the series another look and mostly didn't have
anything to add to David's review!  So subject to further discussion
on the feedback (and maybe a day or two to see if others want to enter
the fray), looking forward to v12. Fingers crossed that's good to go.

Thanks,

Jonathan


