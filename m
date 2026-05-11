Return-Path: <linux-pwm+bounces-8868-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANORHacwAmq/ogEAu9opvQ
	(envelope-from <linux-pwm+bounces-8868-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 21:40:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0867515342
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 21:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190A830071EA
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2026 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9094CA295;
	Mon, 11 May 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkRRfo8h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3E30DEB5;
	Mon, 11 May 2026 19:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528419; cv=none; b=ljzKVJgqFnhb34ecnH2rHxCnhjnmD3vK1yKiuYzpWREStmcSIk7dhSbi54fxNvRjV3Z+Ve8dixyJNGxRj2R6wqPzEUpAQ+Ko4sQtNnfFm4JX3E80T3zSxzkAIvz9lVDW9CiiyGvjo3DgnylCFoaTGaRy7m0bRrHXUvu5yGs3NvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528419; c=relaxed/simple;
	bh=/6ftpBXC2aIHq+a9hymBxjM3BrTyaeZmEYrXz1DsS30=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=e8dlVjA07edHVhiBFcqQRUgYtpZWfnZmWsjvGji6eBMBBw7zb3zCQFT9W+qCK3Il+dUuj8bGG4AmbyLP60KGt7IILgX69kHkgktupPP2hdBvda5exEmrKMsifSmir1a2qVIHwbZAcPEE2fz7fGlYn1W4FU0LlKR9FlqCQN9YBII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkRRfo8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64229C2BCB0;
	Mon, 11 May 2026 19:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778528419;
	bh=/6ftpBXC2aIHq+a9hymBxjM3BrTyaeZmEYrXz1DsS30=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=VkRRfo8hlV5fXTIE6fqKE0FXElgET8mV50cIqVCK0iAOxYY70u3/AI+j16GxjHUBV
	 mCo4WmqtwTVjYiiqEbVOBI6qP38YW3pEbYz7eLb5HzSdi1c+u+4beZyVUS0keaqG4U
	 FC46HFywd3VnYrQE+WefB4aNocY1KlFGCt9XuISymdOx1MXpr0CfaHMVyB7cg+uovl
	 tqb1cvHcUk5QrmOmtW23IHSlRuWNCWGws0ry3PcY2rMfU3ZsefuhJeBRK0UukbchUO
	 2mhwi5ORRKlBhJbVYrw+1XZ3C8qPkfA/Zr9L2IlLhPnrAEHerD5dpDp3knunePVcrn
	 l7a4N9D4WwuFA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 21:40:10 +0200
Message-Id: <DIG3PCJEMPQV.1IAU6ZXLNWP4X@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 03/25] rust: device: generalize drvdata methods over
 ForLt
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
 <20260506215113.851360-4-dakr@kernel.org> <afyKqwxDxu3cT7U9@google.com>
In-Reply-To: <afyKqwxDxu3cT7U9@google.com>
X-Rspamd-Queue-Id: D0867515342
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8868-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,intel.com,linaro.org,samsung.com,google.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,forlt:email]
X-Rspamd-Action: no action

On Thu May 7, 2026 at 2:50 PM CEST, Alice Ryhl wrote:
> On Wed, May 06, 2026 at 11:50:39PM +0200, Danilo Krummrich wrote:
>> -    /// The type of the driver's device private data.
>> -    type DriverData;
>> +    /// The [`ForLt`](trait@ForLt) encoding of the driver's device priv=
ate data type.
>> +    type DriverData: ForLt;
>
> Associated types support ForLt natively.

Correct, and as it stands DriverData is only directly used for
Device::drvdata_obtain(), which doesn't necessarily need the covariance
guarantee the ForLt bound provides.

However, I chose to use ForLt regardless as it prevents future users of
DriverData from running into the covariance trap, plus it keeps the code mo=
re
streamlined in the driver-core and in buses.

