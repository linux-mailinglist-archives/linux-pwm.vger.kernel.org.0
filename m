Return-Path: <linux-pwm+bounces-8208-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGSQJvcmrGk/mAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8208-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 07 Mar 2026 14:24:07 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1543C22BF07
	for <lists+linux-pwm@lfdr.de>; Sat, 07 Mar 2026 14:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4AFE301D95A
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Mar 2026 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127AE274FEB;
	Sat,  7 Mar 2026 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="by8uXhZu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382225A357;
	Sat,  7 Mar 2026 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772889845; cv=none; b=lfipDaQxvxG8+OWvcHhzlRlnaON/yAeXXmz+G/W5a4UFmUYainnS1yy2EzwE/aCMvTBEnTcqIdxPAdJtLA7kBCcoclvI52NKM3yIIy/Gef6+VXIbqrJ9t4xQQtP1lUkhgJmfOr5FHyqpMyPNJr+Gb0me+G83bp9xpHhF0iCIOHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772889845; c=relaxed/simple;
	bh=32HdHww3UJmFEhVmnZGoAosJ3XBp2peMjIB1oX4JJXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGOjlbXQ1Mgs9cAfFoXXgIWrvxUi/AtjTPxH+mfvzhfzV6lw2lF5PJoS4myxEvFYx+8EygsU5WjLCV3KdhYD/eXrNl8Pl3wqYpOQuAVWtUT6NMYga3YruBuHErnu675+9zmS0v3z5sSPztOuVwGsieuK1G/gsD+SGY6eRqbjfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=by8uXhZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1531CC19422;
	Sat,  7 Mar 2026 13:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772889844;
	bh=32HdHww3UJmFEhVmnZGoAosJ3XBp2peMjIB1oX4JJXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=by8uXhZuvBM7srvPnPBFA57czKN84dExBgJmTcfm0hGTozoSHPmbq8ZIhcH+gJGrY
	 dPciRVy73AwZSFkrKoa1laa693GkrwOUXJSXDXmkI4yXZ8TuEbRUSQZAdZbHr6+8va
	 DF80K6lubZlioy3R76XifaLTg2d3Mg+jfty6SDtghFj/QtcD+iCHpJnqxTwIKmw76+
	 7oha3Y2SyFjwC60i+DDoiV5TmSJ6ndPpTskekzgYx9liq68eLMTFelw8+LQMdLOOKK
	 k81tJBrur3X13eruK6I/TY6XNVH0vih3MlCvxPY0VlkFj7irw3ELOI9NY6N/hUfh0L
	 LGuvAWq2P0R6A==
Date: Sat, 7 Mar 2026 14:24:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: dongxuyang@eswincomputing.com
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ben-linux@fluff.org, ben.dooks@codethink.co.uk, 
	p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, linmin@eswincomputing.com, 
	xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 0/2] Update designware pwm driver
Message-ID: <20260307-intrepid-curly-seagull-e036c4@quoll>
References: <20260306093000.2065-1-dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306093000.2065-1-dongxuyang@eswincomputing.com>
X-Rspamd-Queue-Id: 1543C22BF07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8208-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[eswincomputing.com:email]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 05:30:00PM +0800, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> There is already a patch [1] for the DesignWare PWM driver, 

So provide review there instead of allowing Ben to post incomplete
hardware description which you want to correct here...

I don't understand why posting this change.



> which is posted by Ben and still under review. 
> Based on this patch, this series is a continuation of [1] 
> to add support for IP versions 2.11a and later, which 
> includes support for "Pulse Width Modulation with 0% 
> and 100% Duty Cycle".

Best regards,
Krzysztof


