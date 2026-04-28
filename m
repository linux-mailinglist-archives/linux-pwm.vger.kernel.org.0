Return-Path: <linux-pwm+bounces-8735-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFZLLSWH8GnuUQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8735-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 12:08:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AF4482411
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 12:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 875D3300D61B
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Apr 2026 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB14A3E1D16;
	Tue, 28 Apr 2026 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CW32II6V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F83DA5B6;
	Tue, 28 Apr 2026 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370691; cv=none; b=bZhVeP4BzNZ4hZG10mESD5T24DlZt1iFvrZUrvYQrhO+2jYaP2WHKTtzcLYIV0cC97MWUE4zV+iaWEHJGcN/h4cq9TfSFeLjDanaSn9l7vRMCW6DRgT0yKxLvY3PqWWUDPAEJmLSMmJT8Pn0OESpO43nbvH97zVkxQZrzgWybqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370691; c=relaxed/simple;
	bh=THDA4pSnz8O0I8vbRxRJhS+Zowg7suy5Oc816KLBmBQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=el05fRpq5NDG2Fy+4RlxWi4PpsYlkpMOODqqmdKvXcB9FJb5U09hYagjIBbp/5vaj2BaYI/risDCa0u1F1eMeU3EYk5B3BFWp1T8cjP8HTUH9c+Mdu3z2EsMTnhc9Su0iF0L+atiYMv8dU2G0humRggdeAFRKB1Mu0z8p1DeTQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CW32II6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7495C2BCAF;
	Tue, 28 Apr 2026 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777370691;
	bh=THDA4pSnz8O0I8vbRxRJhS+Zowg7suy5Oc816KLBmBQ=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=CW32II6Vi5epjGbH85TrnoRsJam4VJ57mGOa8wDqbkmv1awiASfTD6wpYZ5Xgo7gt
	 cveKQQkEkfPH6nqNJEpBGD3g+Xnw3q4COpis2etqpyJYseDnU2crRhK4BJUB6izqT/
	 BBGFZyvDciDPMPrGIRRmf/jR+HyOo8a1aePha945K9ehKl7CF2tXAMe48rJbJRd6vI
	 AOh/9OwF+UjCPr9FFE4UHOd2DyvzX8ENL/aZeDmhpQWHfPJbe8/01pckTaAR3t87cB
	 U+DRN5WryXLuj+jE4XBHoNLE7CFUPXylmoECZcniahdwBsDXTMDqij3eepjht1fZGQ
	 QitOdXqeyWx5Q==
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 12:04:44 +0200
Message-Id: <DI4PBO6KS860.1699VQUG68OI0@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 00/24] rust: device: Higher-Ranked Lifetime Types for
 device drivers
Cc: <m.wilczynski@samsung.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
 <afB-p7vhyVYlcTn6@monoceros>
In-Reply-To: <afB-p7vhyVYlcTn6@monoceros>
X-Rspamd-Queue-Id: 32AF4482411
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8735-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samsung.com,linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue Apr 28, 2026 at 11:37 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> I didn't try to understand what you do here, but there is nothing
> scheduled so far for the pwm_th1520 driver in my tree, so

Compressed to one sentence, it is driver core plumbing to allow bus device
private data (and registration data) to represent their lifetime being tied=
 to
the device / driver lifecycle with native Rust lifetimes.

Drivers can take advantage of this subsequently; for reference see the nova=
-core
changes at the end of this series.

> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
>
> for patches #12 and #19 touching this driver for merging through (I
> guess) the rust tree.

Thanks -- as mentioned, it is driver core plumbing, so eventually I'll take=
 it
through the driver core tree.

- Danilo

