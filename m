Return-Path: <linux-pwm+bounces-8740-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGbhOKK18GlwXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8740-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 15:26:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83131485D0F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 15:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A534330830EB
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEA244D014;
	Tue, 28 Apr 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTPK421+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57C44CF44;
	Tue, 28 Apr 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382063; cv=none; b=aTlDwZ7B7ZdU3kIUawrxDZCWryWiXaRfgd7U3LH9gAQb9kknXjfVxHgzymvNDPOA2mXa/05QsDyW1zAUpyhQ9ZAOBf7MxVyydhuXCclm3DQh0SeNSSAENs+teHgjl00ICz2AOQN97p5HswG/b4/W68DImm6W9XaUw4FHMA5aDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382063; c=relaxed/simple;
	bh=fId8M51eLiEA5R+kZZRBfVGDoJPE40PDpQO/FvKYmkQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=h80yk9H7MgSherj4xsVYKBKss3r9KmRLIgWS6xh7/qHmNc8iZ6WnDbh8B96qgWX9Zpr58yiRmTUeOa/PC5ZLTmq6BCdw6qI6QzUA6w9sokIc/3liXIWaBVlBIsYz55o2VS4n1k8fIJ/8nd0EfV20i5QPEnAzJHOmkdv1Uk6Iur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTPK421+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C30EC2BCAF;
	Tue, 28 Apr 2026 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382063;
	bh=fId8M51eLiEA5R+kZZRBfVGDoJPE40PDpQO/FvKYmkQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=cTPK421+E+jI8HRlmLTMG8MYzB5JhrIJ5tmsueJAozatUgbxEQ4wqkQqYzs7i+IHC
	 w34izlUYoBbQgEcEMyKom24HUQY9fHdzABq2989Sxe6X/lwpUcZ326o3iFd/+tZOjW
	 P7gPxvl6kmrE+CSeTCF46fjiuYeibf9V/NFKdpENecwovgqmVH28T4tUnKjDGl7dvY
	 G/DaprRDa0T9Iirz4kmgWf4Zu7YJZ7cn4eCck005wN5sKyFUWS5YR7Dyrlm/Oe8wWw
	 MmiOLjQmBZp4VkVPbHlaeXHOdW6ostFu7NUVoz47o7en03s+nCR5wMACMQYH5pBA8T
	 PIToYoUajX8hQ==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 15:14:15 +0200
Message-Id: <DI4TCSCZ215E.16ZCXW7RSXBF@kernel.org>
Subject: Re: [PATCH 03/24] rust: devres: add ForLt support to Devres
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Danilo
 Krummrich" <dakr@kernel.org>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <20260427221155.2144848-4-dakr@kernel.org>
In-Reply-To: <20260427221155.2144848-4-dakr@kernel.org>
X-Rspamd-Queue-Id: 83131485D0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8740-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue Apr 28, 2026 at 12:11 AM CEST, Danilo Krummrich wrote:
> Use ForLt::cast_ref() in Devres access methods, enabling lifetime
> shortening for types that are covariant over their lifetime parameter.
>
> This is a no-op for 'static types, but prepares Devres for use with
> lifetime-parameterized types such as pci::Bar<'_, SIZE>.
>
> Add DevresGuard as a wrapper around RevocableGuard that applies
> ForLt::cast_ref() on deref().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Please disregard this patch, it does nothing for this patch series.

It sneaked in from a subsequent series I work on which makes device resourc=
e
types, such as pci::Bar, ForLt!() types themselves.

One difficulty is that ForLt!(Bar<'_, SIZE>) fails when SIZE is a generic c=
onst
parameter, as it would require generic_const_exprs.

