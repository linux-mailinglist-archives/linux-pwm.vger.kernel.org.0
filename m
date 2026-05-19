Return-Path: <linux-pwm+bounces-8996-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gE6/OrdFDGoGcwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8996-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:12:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6F57D490
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B374316BE19
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A94D9902;
	Tue, 19 May 2026 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlzyzTrf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAC4D90DB;
	Tue, 19 May 2026 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187164; cv=none; b=nJJZvg5s8VKojuFE9+fHfqdFMcEZBZGDA5h0p+6kh4U9nWg5IWpCU5UPpC3xgaWs1mArTxhP9bC57MJq9GOrqxxg/UDrc2I2Fz6ZPDUg/VZx0TOyEfTUqwbVBPJ4wBunodRG55L9Wv/qYlq34r63d3oM8Gm+sZsTrdTkjonnveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187164; c=relaxed/simple;
	bh=5J8hmX1CCU0iLcpPMu5NtOM8FHJanErUGlCyNObqAGo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version:
	 References:In-Reply-To; b=W0aPMzYGJMEtWJ3nsWgpOjpX2Vg0Z3F6LZGitk6xEsbxITL4RCcrsgy0eWJfemcbJ+jlRNKhdlAp2Cim3xZa8Gbh4OIL4BZ53s6i9hUwUJMq8Ad8bn6LBucQt6jsW6DHT6xfhI+y2Iz3cAdfX73Xv7WTG2G4aBMXi8TG1UVEP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlzyzTrf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C81C2BCB3;
	Tue, 19 May 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779187164;
	bh=5J8hmX1CCU0iLcpPMu5NtOM8FHJanErUGlCyNObqAGo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=WlzyzTrfiapXBcLy/6izyhFaE+Ulg7HRdIMadQ7hTDarGnJnez4IPmK3n3+FbUfEX
	 0qCGQS2eEE4Uzmqq4tltIvQLCfObxCmFIn2R8idpC/VvAmw8bf751KtnrYk3y8e8xf
	 puwIBSuda04tXtpDp/1k37aHCAp2Nezb0a0TdrIBn7WZ5bvhQnCm4wqetagni4o5yt
	 1LOWieJIVCn7g+Z7zBAuUjUpGvPSWZG5bpdIqJ3vDjWMLIvurI31NerM+pInCA2fkv
	 QxFzIaYcjvwpYJciL5pSSZlE28Pj5ZYUy4pZHmD0G4HKc4n2nmQnk+kBO1/7a1g4hf
	 j2eAV1vQ7jG+A==
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:39:15 +0200
Message-Id: <DIML7JNOV84D.1CK4G9MBZQJ3T@kernel.org>
Subject: Re: [PATCH v3 17/27] rust: auxiliary: generalize Registration over
 ForLt
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-18-dakr@kernel.org>
 <DIMHR3ZPEL92.2HVZ0FGPM54MF@nvidia.com>
In-Reply-To: <DIMHR3ZPEL92.2HVZ0FGPM54MF@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8996-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6EF6F57D490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 9:56 AM CEST, Eliot Courtney wrote:
> For example, in the next patch on the sample aux driver you can do:
>
> ```
> let data =3D adev.registration_data::<ForLt!(for<'a> Data<'static>)>()?;
> let pdev: &'static pci::Device<Bound> =3D data.parent;
> ```
>
> and mint a 'static reference to a bound device, which seems unsound to
> me.

Good catch, I applied the fix.

Additionally, we could probably reject unused lifetime binders in the ForLt=
!()
macro, which doesn't help when used with a type alias, but may be a good
defensive measure anyway.

> What about requiring all device ids declared to be supported by an aux
> bus driver to have the same rust registration data type?

Please see [1] and [2].

Thanks,
Danilo

[1] https://lore.kernel.org/driver-core/DIFBME3GXDC0.14UHJTPD6TTAE@kernel.o=
rg/
[2] https://lore.kernel.org/driver-core/DIFXM2N21Q5J.2RIYLU11C5FR6@kernel.o=
rg/

