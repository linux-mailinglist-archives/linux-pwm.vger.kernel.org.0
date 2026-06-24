Return-Path: <linux-pwm+bounces-9367-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A+90EZkcPGo0kAgAu9opvQ
	(envelope-from <linux-pwm+bounces-9367-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 20:06:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9BF6C09F9
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 20:06:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bGwmU8r2;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9367-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9367-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D4183039C93
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA4C37B41B;
	Wed, 24 Jun 2026 18:06:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F61199EAD;
	Wed, 24 Jun 2026 18:06:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324374; cv=none; b=dklZ9rEdZDzU53XLBCDda8cNZLphypR2QqWEevUGNk5Ma7NGOWF8IPjE6wTg+bYePGEQwPSW5ukF2byf90RSJLQc8/TASn97A+lSER+pKOLePbKA+pLaOJUbc+7z2ZCxN8XDdtYjL3RhUm1aKlwvTSoOh0uw3XLoGib83TN7OXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324374; c=relaxed/simple;
	bh=CWV2CodazpVWAzDgOY+6xdyScP/u+sw4Ii7YvacgkJQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Z+BtZ2ia00zsJH2JmDgbILpNA9PgfykPtWjQbd3XTZoSoEipm01TtYmGvSXsLpabAeQfYd5tx0SznIqkZ7DRESDJT3FQBkVcYZCF78ir/qI27O4OcqYFPM2NAdmINu00qGT1vfn1at9iNVp+fYaIOG7EwKt+oXPViFA4ZW1CG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGwmU8r2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663D21F000E9;
	Wed, 24 Jun 2026 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782324373;
	bh=CWV2CodazpVWAzDgOY+6xdyScP/u+sw4Ii7YvacgkJQ=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=bGwmU8r25CyiS49E2J4yixw3fklzXhkreiNNGZCZJLrHEjUOrLHHgH2HzUKaZXD/T
	 PdlNtWGc0Enj3hv4vYppf//zdQvDwHFs7g919BDTTbB3CDI4HGWEyo0bO9oOcWBbGB
	 A4kzpbRJ6xuyfGyHmcSXFeaZTterFr//fT7MYJNcEONMoPQMdQbSgR0jLp8ay1ezQk
	 4LZ0nwzRg/GFAIykoqSOqUtAdoXecWRq5ceqXxyHwUM00RD5xtmDxnF0Jt+EZ2L9WU
	 mTgrY8NCMIx3VhOO61atxi3U9Wux+gNCIsQOuu09D4VHacGs8X7fNcDJ8iKtoMJLMC
	 5N3MznGMNHk4w==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 20:06:06 +0200
Message-Id: <DJHH9AKHNQ3C.3K4CWFQE5P3NU@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 2/7] rust: types: introduce ForLt base trait for
 CovariantForLt
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-3-dakr@kernel.org>
 <DJHDQ7X94BXR.2XYSWSK79USDB@garyguo.net>
In-Reply-To: <DJHDQ7X94BXR.2XYSWSK79USDB@garyguo.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9367-lists,linux-pwm=lfdr.de];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:acourbot@nvidia.com,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:gary@garyguo.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B9BF6C09F9

On Wed Jun 24, 2026 at 5:20 PM CEST, Gary Guo wrote:
> This is still unsound, as I mentioned in the last version that the prover=
 must
> be kept.

Heh, I think I just forgot to finish this up, good catch!

