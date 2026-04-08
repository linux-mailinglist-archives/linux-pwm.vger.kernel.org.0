Return-Path: <linux-pwm+bounces-8523-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMVWJ8BX1mlJEAgAu9opvQ
	(envelope-from <linux-pwm+bounces-8523-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 15:27:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ECE3BCD87
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Apr 2026 15:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B83FE300E2A0
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Apr 2026 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7A13890EA;
	Wed,  8 Apr 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoh+6y2I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC7A3876DF;
	Wed,  8 Apr 2026 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654845; cv=none; b=UEh1eJ4ymrH0vT4TFYdWazmHR0qvpUHaA76dUlIvY+3mM/lQjZWkFfo60cthMd0muu5DRuw4sslTER8+/4D+hyUNzjXWN1ZD8s2BS5ZfA6vJyL7VC7NmK/+nr9wSePc3/u+UDuUIHqSmc3BQpD6BIOPryUJU3N5CXtD7nCDlcAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654845; c=relaxed/simple;
	bh=18uxEuPzlVb3uXCjxYm9t2m2h0lPnLgK4BygM0pumqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWRnCgPN8dYrm5VyQBteBy6yW659kuTsZUCBcvip5vVaBaf7yQURxG9qT3INQXs/+nTNLd2Yb6CGou+tsjv5/i8X46oNYhFeD8NAdf6HpVyhdjoE2G4tyyr8uk4V8+3bgX4didb6gbYqL5jtQb07MdMhvexwi8cuM08vnEbJHwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoh+6y2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E700CC19421;
	Wed,  8 Apr 2026 13:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775654845;
	bh=18uxEuPzlVb3uXCjxYm9t2m2h0lPnLgK4BygM0pumqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoh+6y2I0eeZn8tFL7c0CkErn3kbPrd6Jgg53dI6GkDUDTX5lFLl179TiMk088Ycy
	 ka9D2EAtK0Pzc7QETMhmlwS2sjmzrKhew3AnCfvGxy5Lb/tkh+lnyNghLwgzH5ZOSO
	 C0kOSsnHH/lL4tkd7T6eb9uksmEOjjzQ7wgVjv2tVVzxM4VnAqYIaYDB4qHMbCHRzW
	 5vQwD4992N6UU7c15sAZP+Bl2a/GorcxUs4hHampd63EaEpcFhHQ6wxYKUs1g+XUJk
	 jgX4Okzcwx1xqkGNABmKNEbSZmtJUc4snv2fbvmUe5t73vZT/10jpIirgd5OtFG3Jq
	 jT/O2iY0/ludw==
Date: Wed, 8 Apr 2026 08:27:23 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-pwm@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: pwm: Document Tegra264 controller
Message-ID: <177565484263.1938646.11666274671609620295.robh@kernel.org>
References: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
 <20260331-t264-pwm-v4-1-c041659677cf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-t264-pwm-v4-1-c041659677cf@nvidia.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8523-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,nvidia.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 53ECE3BCD87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 31 Mar 2026 11:12:13 +0900, Mikko Perttunen wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add a new compatible string for the PWM controller found on Tegra264.
> The controller is similar to earlier generations but not compatible
> with them.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> [mperttunen: Drop extra Tegra194 compatible string]
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


