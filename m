Return-Path: <linux-pwm+bounces-8514-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DVEO8ct1WmF2AcAu9opvQ
	(envelope-from <linux-pwm+bounces-8514-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:16:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D73003B19FB
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Apr 2026 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F23B8305212E
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Apr 2026 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9543CD8A6;
	Tue,  7 Apr 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOsSgzOA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0580E3CF05B;
	Tue,  7 Apr 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578120; cv=none; b=j/n1UCLsQ4zf1QD9d+3r4HdqMxZy/Bv4IGzw+aO3XLMwkb0u9hbZcEKTSFcbcPxsMmf7X+mid8PdDFvxg7JxIbpQbB78HB3Bl3BatxKu33j5rICcK7TDjdII49/ypQcTsIFvD9mKajccpoqt0Hk+T/AUn2nLWVMBKdQLG6y+G0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578120; c=relaxed/simple;
	bh=xYShYm9bxMjZrtIyKYredjisEXJj/O09esRnvDocgB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGj0acBcVCW3oD0zLmdW6/ZO01wE+YYzkL6+7HhdUQ1pxAdclD//zaJQ+jVr8DiFAob0qK9Ml6cA8/LFbbYIIkCZPIqkgtXKkn9eQx9wt/Hyr81kRDzi3b4NmSCLb43xeChjh7FvxnZfqB6vcB18kM+oVhsbOqgIWlKUrU8vTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOsSgzOA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F02C116C6;
	Tue,  7 Apr 2026 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775578119;
	bh=xYShYm9bxMjZrtIyKYredjisEXJj/O09esRnvDocgB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOsSgzOAeLNh05Vesqd3XGDprBYHhayV2cKaUDAK75bko6lqaAreMFyFCUz3lXm45
	 CbZ/v9quohodNaZDDQ8dwlFKC8j9ZdwPGV1CGpHNynsLl0qvyvsG1CFVETvirIQX5B
	 rAFd8Z3uX1SyWG7XM9OG/ZjmxUHgbgydlnOwvyUVT79/GcfiYKzpvCCnOAwyrzE6xk
	 3dJTi+BA6Jlmo/UFv50ZAOzWd7U8qrNhydC7de9KJEaScj2u3Yb3NAK4VtC/0Mxj6S
	 rgO+bsMGh0Qt0XB1QU3MZmjDbVUPCCAUSPge8yk4RsCrTtbG7ms5vgZbYdQEuBJ2Sb
	 a3ZwcVNwQYhtQ==
Date: Tue, 7 Apr 2026 11:08:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, devicetree@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>, asahi@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org,
	Mark Kettenis <kettenis@openbsd.org>, linux-kernel@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, linux-watchdog@vger.kernel.org,
	Sasha Finkelstein <fnkl.kernel@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	Neal Gompa <neal@gompa.dev>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/9] dt-bindings: pinctrl: apple,pinctrl: Add t8122
 compatible
Message-ID: <177557811572.2663241.13106736229238286122.robh@kernel.org>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-5-5842e1e393a8@jannau.net>
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
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,roeck-us.net,linux-watchdog.org,openbsd.org,gmail.com,gompa.dev,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-8514-lists,linux-pwm=lfdr.de];
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
X-Rspamd-Queue-Id: D73003B19FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Fri, 20 Mar 2026 13:23:23 +0100, Janne Grunau wrote:
> The pin controller on the Apple silicon t8122 (M3) SoC is compatible
> with the existing driver. Add "apple,t8122-pinctrl" as SoC specific
> compatible under "apple,t8103-pinctrl" used by the driver.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


