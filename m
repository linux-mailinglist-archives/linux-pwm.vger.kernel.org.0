Return-Path: <linux-pwm+bounces-8109-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J5mAwKEimmfLQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8109-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Feb 2026 02:04:02 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4227F115E56
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Feb 2026 02:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37070300A7EA
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Feb 2026 01:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206123BF9B;
	Tue, 10 Feb 2026 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBiL7rFv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39217BEBF;
	Tue, 10 Feb 2026 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770685438; cv=none; b=cX71PZISfZaA8Wypw2myXuz7pVaUBSjPR89vpQfxk/uMcZNB3VNwZh6+MyBYmbFKiWk57eMb25eZrgItrDI4Avl2Oz5JjiEUBSv/B3jbp85uKbG7LHV/0uj7/dpcMkVXgrOmKrPXUJHT8NWdc4+Wq/rtTzHP8QYFQ8L/dljpA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770685438; c=relaxed/simple;
	bh=hakQ46HeCoC3OsQPMvdoHAvhnRfGDwvn9m8VTJO3oJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5LDYck9OsDxo8sBqexESdXpqucFYJ8BKBdacUThPVwH/6oNY1sbIzlOSsAowoCyl52+Oz7SaZV159TFow+FZW18hGRdUvYIWYFMrp01rFvyQXbsU8qxzbzyAbWpcDTnRAPffbHrwoYXHG9pgJop5DD7+8PqZEpxe61jlGHbeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBiL7rFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3653EC116C6;
	Tue, 10 Feb 2026 01:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770685438;
	bh=hakQ46HeCoC3OsQPMvdoHAvhnRfGDwvn9m8VTJO3oJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBiL7rFvS784k6RcaTT19OC+fyZt97II7Nsv2KQxRWw2n993gOcGAf3kxXYMLJ9DT
	 4SpWJlTsUBoqZPYGJdZh8pId/Oiq7homhvrc0KI6y6Gkg56fPuB4Hd5ioTm0z9SGGW
	 oiO1ldU5Pf9IVTS6f+nvGhaPae/kapXzV+68N+9alenCItgCFpw+1qJuOE7AGUe1ea
	 FAoqNNe4bJtlU4LHpF+3ENnrAZyDv0qJCvANXHpxn4XxKN1eO8oYaVUEM/G2Q2Dui3
	 FusJ2wFXq1EXhkOobFcjFj4cCTO7IMwUa0o8QmjrKqO9UhhDtA+K2BB4NuoeSO3wB1
	 yhATe17NFXFsg==
Date: Mon, 9 Feb 2026 19:03:57 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: add support for AE350 PWM
 controller
Message-ID: <177068543680.2243845.4972830102362749222.robh@kernel.org>
References: <20260204-andes-pwm-v4-0-67016bb13555@andestech.com>
 <20260204-andes-pwm-v4-1-67016bb13555@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204-andes-pwm-v4-1-67016bb13555@andestech.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8109-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,andestech.com:email]
X-Rspamd-Queue-Id: 4227F115E56
X-Rspamd-Action: no action


On Wed, 04 Feb 2026 19:30:41 +0800, Ben Zong-You Xie wrote:
> The ATCPIT100 is a set of compact multi-function timers, which can be
> used as pulse width modulators (PWM) as well as simple timers.
> ATCPIT100 supports up to 4 PIT channels, and each PIT channel may be
> configured as a simple timer or PWM, or a combination of the timer and
> the PWM. This IP block is a core component of the Andes AE350 platform,
> which serves as a reference architecture for SoC designs. The QiLai SoC
> also integrates this controller.
> 
> The binding introduces the following compatible strings:
> - "andestech,qilai-pwm": For the implementation integrated into the
>   Andes QiLai SoC.
> - "andestech,ae350-pwm": As a fallback compatible string representing
>   the base IP design used across the AE350 platform architecture.
> 
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---
>  .../bindings/pwm/andestech,ae350-pwm.yaml          | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


