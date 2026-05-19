Return-Path: <linux-pwm+bounces-9022-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ+rFSFoDGpXggUAu9opvQ
	(envelope-from <linux-pwm+bounces-9022-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:39:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04757FD87
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C138E301EB53
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C42F348C71;
	Tue, 19 May 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3QKAkOH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956C348C65
	for <linux-pwm@vger.kernel.org>; Tue, 19 May 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197670; cv=pass; b=dhdeJ85G8eGI++4qZQYJ6UxP+I8jtQ61eogsTrIiYTsPsXpVa79ViddqYEwKVQ3pSisTw5LL/lWv2thcIgW2OEO8QfYCW+Ozhajz4lV/QMNq1jK4+lEwlRh2ufYs+6KnoIhtag36H55ekShsI93ponGD+2daUsFNAq7B4el6MyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197670; c=relaxed/simple;
	bh=naF+eFIBVaPQxxaOGNrVUV2zt+dbyRkLeG9JHqTunLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghcEnogt2OitBNsYdXMz627IpPLM8JyuYs4aw95Q4JBM8Qxz2aaMYmWckKXkyAQcqpDHy9Iu0dk0sN0dnc+1Q1MHj/akkZ+rsbP1voJxjSfUcTM0wY6WvsVQjc1aOty9fkoBxnYfpNshm6PaO9xFLVnHpt5p/MQdM5SguOYduQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3QKAkOH; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f6e6a0a215so213654eec.2
        for <linux-pwm@vger.kernel.org>; Tue, 19 May 2026 06:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197668; cv=none;
        d=google.com; s=arc-20240605;
        b=Jf0Wi+GsKRtztz2rrYWURHouH2QCaCePDVLFv3BAFLgmzlqeSxVI0AUBHCERPpiHtv
         AYG/qxNPghN4rUU0aKE4NPmq7V7tFf432eQLYpa9jLC6UeRKCQZzjlkhX/lGuTK6MFCb
         +jJbA1skhl7ktFuZjm335JDTI8a6HeAF7kXNFA23hPpCoByX1QI1yT/1HCpmVxWHD/RJ
         rhwabMtWdm6yVf+yxDw90lHujhHBouJf5B4nv/Y99QOu/bgJaoaVP4MYmIrxpbZu/sxB
         0izMjTYN/w+3iKCoTz5nX8P2/ivslWaNiXCSPLMfo33TyWnKTQos/9UWY0ANWS26kMXM
         Mw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        fh=MMnhjYIPoEw6ZIGF2kPLXvv0y5YjMThexv/IlOskrPs=;
        b=eY6l0IZioIGylLyoNemVdWYSMPshN1lFrV2F+sMr9oCfnZUACTzZ9F/Qdqjz27jjKd
         TNOdnuyFlW10Rn20xcemL2tR3LFNI/4f+SWYsWPbYFiO6IBtoWk6MA/jrUCVwayVG0+Z
         Ejg5FZ0EPASMJu3EC1R00FNjvWCgEZaNZ8PZjqOVzNCx07USp3VXkPPLtzaqGSnQ9viK
         grUNaGo9sljdMtGMnVSXLP6+w/H+YrVKLe0l7RT/9cbPn3nWvw+vHNrzxm2T2inrqcV/
         UUnqTlJBpXS8BNGO2tp+UcFiHQJrQjmgNCMGPUoqQBa1/p1DtBbowZnfPmAEcRCA9pnG
         IMNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779197668; x=1779802468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        b=Y3QKAkOHC6LcGS5ofPga3r5bKLfejRPRa5knoWuBdjIQPROhsMlxoCgtWmEDooiLsm
         0+80J+YEhGUXdmi5bn8r2tmzxbHS18gfwjoF9FB1iKPEfkqvByO7GeN85Ge6jjDuaS/B
         UGejyckurv4npWtPDzpzm1RJ87DSXK2HvX+PxJ4BDXkVpSEZfe18oGhU0vJBd3EkhHsO
         ZULy6yrBlR05xc4N5tXJXxbjda/Jwd4iYxb4A6OPBsDNsUc35u62UEuzkwYz2yVcpC2c
         Sj8IexBkLvoJvITBQ2aWGpVgscMHQcWLFEYxaAtCXBVe6CU7A77UligOFth+txU3f362
         0trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197668; x=1779802468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        b=P4IA0+fK8ZGvIK0NSfWWygClzNxqfUklZNAmXC0P7slKJ/3FvY7dyNq1srP9YBMKb8
         IncGtvCAwYI9hEcBmR9/LANjIrxOiEyuJXbO7S2i8KNxCqY75LGZ7PxG7nwLz+TfER58
         DuEyte/0y6hb0AhJIPzX9QbohtGrfnET5udQ9rRVDIszpz6wTGCdCi8t/+F8iLKEbDg/
         xPFtcT9Poe69I1rk+BXIWdMdGbuKVdmRk+Sk8yakaG2uyDgQxPUO7tJrgFiFEAgSahNk
         anL569Am1pUXmLmLFU/XmmSYAkOCxQwqr4NkQ84DugMxgHC+OJMBgfESYdY51ClY+3bY
         Lq8w==
X-Forwarded-Encrypted: i=1; AFNElJ9xSjSqRtwsV5TOPflIjDFOPpQi8x5IJbeQQq1WO7EHw4G7KxTScpuvTvPr/ImPrq0JcfFimxmdJKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcyZ6eWfdzlSGrmbVgUR6o0ogHmc73Z7xqQvmwTjL9sCY6lxa
	xqAhGDQSyHxLYlhDvJ6Q5kRDuIpYOb5Hc9QezHQKR0rroGtkMEzX/UoFTcRDKatKHZtQkNSedhc
	L4dQKtj/l2dHpi37S6K7SSHYYsCuhPZo=
X-Gm-Gg: Acq92OGy/g6p+HqcYvC2AiFKPtOsCvvY1IB0b9pKhHv0Rz054Km5+qxRquuHVfmrEqL
	7sytcvjzrCPLkm3Z7+7OZ4rxfsX7Wih82jSY4HPYH0DMxzCFMqkbrVf108qlilxYQNHx4fggHS3
	ZqyaE5EdN84ui3jMEBw81pkwOuwlxbJ2SnHkZfrN7FYmb1JctWTgWJ80DbZqb5AYY8zdY7nx10X
	wfElvgVqm/LnLt2i1BSKCQjBS7Xg5+6SriTHuYq2ouQB8GWHeXs/CyIzD/elUWPfzBYtDCTJ763
	CmoRl9/uvpVrCp2wkZ84Vp2hcPEYOq8tOyItXS5IfnrJDZl4KcvE3q+5jAkwRar1gDml2Id5qtG
	Xr13fhfWX4Oe2tBB0ALtdhcQ=
X-Received: by 2002:a05:7300:dc14:b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-30397b88952mr3989391eec.0.1779197667973; Tue, 19 May 2026
 06:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517000149.3226762-1-dakr@kernel.org> <20260517000149.3226762-17-dakr@kernel.org>
 <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com> <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
 <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
In-Reply-To: <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 15:34:12 +0200
X-Gm-Features: AVHnY4K5vpbJGhCh2fM0bDGLH-gDIENRDMeBQsxYOoXtqTcl9WixZ1bWmTIZnkI
Message-ID: <CANiq72myVDq9oLyyZqUf3Se9-JLDp=qGhBJy01nOxMaZBRxADA@mail.gmail.com>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Alexandre Courbot <acourbot@nvidia.com>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, aliceryhl@google.com, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, viresh.kumar@linaro.org, 
	m.wilczynski@samsung.com, ukleinek@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, abdiel.janulgue@gmail.com, robin.murphy@arm.com, 
	markus.probst@posteo.de, ojeda@kernel.org, boqun@kernel.org, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9022-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[garyguo.net,nvidia.com,linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CF04757FD87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 3:03=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
>       That said, I expect LLMs to be (heavily) used to write drivers, and=
 LLMs
>       are typically trained to be compliant. So, I could imagine that a p=
rompt
>       along the lines of "Can't we make this work without unsafe somehow?=
" leads
>       to an LLM abusing this, while going unnoticed for the user.

Could we steer LLMs to avoid that? e.g. adding a line about `Unsafe*`
items to Sashiko's prompts.

Also, a `checkpatch.pl` (or similar) warning may be doable too, since
false positives are OK there.

It could go to the ASH (Acknowledged Soundness Holes) list we
discussed some times if we end up adding it.

Cheers,
Miguel

