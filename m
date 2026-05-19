Return-Path: <linux-pwm+bounces-9028-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM1aIaCdDGq8jwUAu9opvQ
	(envelope-from <linux-pwm+bounces-9028-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 19:28:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B35830B7
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 19:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA3CD3006D7B
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AD630EF75;
	Tue, 19 May 2026 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwVfu29S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716263DB31E;
	Tue, 19 May 2026 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211675; cv=none; b=RG2vaT72jYFclMZmVy/jlF8IJOo/gXCG3FtBKumW4WVnZbmvQfePmXxH7vCpcvwBMATc3wnj5ur9ip1jaWKiXWBnhJps7Y1MdIbgW9d1l+kDJjGhGQtcmk5y83s2p2PIyOnmn3S628TZ5LjcVvi8CmzWEE/m8FzlCJi5cNBORlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211675; c=relaxed/simple;
	bh=KBC3Nc4aH72MDDN7wEUpqS9TMs92M6VFHpdyi/AgL2I=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=jONZACKjtBewcnn7jP48D+6OsBz4MNhgV/wWMhs6S/k1EBxz6MdQbij6LwT9gpJhTqpqngnSyIFI4DjOP26pLfJSxkAeYU8RWrA+bMXQhKCO+NUMX+FJVM28bmnV3XNVoZyY8ul+NEG95+woBDnUczXg3Nqm6OQfWQ+2nwk6Bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwVfu29S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC5BC2BCB3;
	Tue, 19 May 2026 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211675;
	bh=KBC3Nc4aH72MDDN7wEUpqS9TMs92M6VFHpdyi/AgL2I=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=jwVfu29SblsG+4P+aBXxO13QJS40NiLgL8mIXyl4UEhXpizahXky04JFQtE1jdXm1
	 KcmoWZXj/8EQx2z5HvWz2Y31jSxHGvxx2LT8p1pd1kkkoZq62V47RYGYHYyOEjo2LE
	 Vv+Sw7MdeySOwJlJCye/ombzPr6lwUTRFVSFxGKyQchG7gtZJnK3mbvsnx0lRgALQq
	 JEiPS+ZG7Z+PVFQGEdrd4cO1b6Lb5O6rgTnM9rGi3SFjL9GrNPyEkH8TEJuOAeFTpN
	 QpXh+mizIZH72OjwMIjOqaaOv7nrO39VjZvFKptfuiQUD9buI0kHXKn3r7lCAIl+jy
	 C+7fSOwjTK/NA==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 19:27:45 +0200
Message-Id: <DIMTWBHV9E5I.1X2L8UNUWLVT3@kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 19/27] rust: pci: make Bar lifetime-parameterized
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-20-dakr@kernel.org>
 <DIMSJVKTYX6D.AEN6OPPC2898@garyguo.net>
In-Reply-To: <DIMSJVKTYX6D.AEN6OPPC2898@garyguo.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9028-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 866B35830B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 6:24 PM CEST, Gary Guo wrote:
> Either way, I think we probably want to limit `'bound` to cases where it'=
s
> actually `'bound` and not some possibly shortened lifetime.

Agreed; [1] for reference.

[1] https://lore.kernel.org/driver-core/DIMTSQS1HZM9.326ZOXFP6PV5J@kernel.o=
rg/

