Return-Path: <linux-pwm+bounces-9647-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Az61IAFzTmr2MwIAu9opvQ
	(envelope-from <linux-pwm+bounces-9647-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 17:55:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AC472853A
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Jul 2026 17:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nGPNCDP3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9647-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9647-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8B7531F90BF
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2026 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6594B3F12ED;
	Wed,  8 Jul 2026 15:25:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EEC3F12CE
	for <linux-pwm@vger.kernel.org>; Wed,  8 Jul 2026 15:25:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524332; cv=pass; b=q+hu6JG1k3jvl3YiPTTFkGjVEtV4GUEs38hmbQ02Ok4PzMX0yJayTa1aAIOY3a8719Dp+jjY/W9HvxEzndwTNshrH692sXVmmIJhJFkDuuIpGWcu0RGkTpnjRMzRTpey9UOBI6BzJ7z4aSKT0DbyLPXTAfrhYqWz+m++1s1YqBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524332; c=relaxed/simple;
	bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwzwXFL+ETchwqYujIlrCXykRxNmb/sJ6pvnqFJ8PAlqi/yMjL2BUaF0hNBQP2i7Z6JcED4kMyw4cKZ3BikxXaG1cRgGZse8SwyMbMR77Sx0upAgHD0wGsFmVkWe2SNVkERgYDsIUJpBbQwA1/kMfp/8DeQ2HotvR+3Erl9Dx0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGPNCDP3; arc=pass smtp.client-ip=209.85.208.180
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c699b2400so1224201fa.2
        for <linux-pwm@vger.kernel.org>; Wed, 08 Jul 2026 08:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524329; cv=none;
        d=google.com; s=arc-20260327;
        b=EMukRMx1GgDSJZ/Xg10so+I/6saG4dDODkHRpNXJNqNprsN2wcu1amLXc1eAtrIsp/
         2UsjKFq+ok6nBy+6g5U/1SjanKbbtuVXP4JJ5DpcwgoETmkQJDo1qp3tMGGegfR1xWBG
         3isVBwe8Qzz3YMA3s7rzGMTk0JZFglYsfF2cHpp8GQLkMM3fXVEgOcSbn63+cew0Rt7I
         CnbmRfFk8F4k9YoVArbgy5VghyWOG2WobS3hW0VlzCtoA4kWwMCTpoNfBdBlU73IKhu9
         o+u7tmTscS0KHdAGZc7Gi5JgrrYpQixZ+5f+K9szyYHkupxwtMS7raKEg/fnyDwcJPL6
         R1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
        fh=AdG5094PDdpGnCyotwWeu7CC1wC1dgNuqAmC2y5QkDc=;
        b=Hch02q8TSFjTABsLukAN258bsIiHGoxNppPgLBzJzLK0Lwfp14SyttKLIme2dGisdK
         wLjSk47ra10kz7wWBisH/y9T7Zf1P2fBxlgFDNCcZdd1xpb00t+ekPuYFD/aPC9CCc9B
         NCgZ4hGTVuB452o6pXr6pYA+6yg/LuyuIlQ5uJddW7YXMWoQeL7Ur4odEcr2aIk6hWBR
         W2RaGxKBDWKXPD2q1pmb1LAq6BgiavnKd0vw25h19slvGHHUnP8sA2whXuQN/P8821Ty
         sqhc5DHShSv5RJQrMeR1mA3ExfS3gPEzFakyrV1YVbhubAprMEcviiWVAiA4aszJayhP
         +4hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524329; x=1784129129; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
        b=nGPNCDP3zX/JD7JIelS2PhEF+dnHsaiaOhut0qhiHFhIEdMQNv8rhdOteRKRyKDs+O
         MTuI00PiiCwOq2+M77Y9nUMWVSuOrAmNnLqqspkKUVeb7agC/GuayKrvlRzD0hurKyKP
         LQU5pDCGPN4HjoMMdqdCivY23Hb+OM7SBGpQiihaFw2Nqw9UssGn4fktsrrI1SzCGoeN
         ssHsz8WZnXSmo50VjEBo2+1ewIYnjbK4BVSh4LOGnxdKjcz1vBX1SwGcsn0dQQknRNZH
         Is/U1H7JjvTzL5BjnySPwPTbGeGZ/F8uIQcfWdHXZdP6kUJqCXhZE48cxU/07dfmohO0
         EyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524329; x=1784129129;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vOZfMiEQfO6pItb9Vox/F3+dXN8hmkgAn9QnqBq/R7Q=;
        b=H499aGxWmKjyBnLC26YmvvyxDrLiPfkQ8LOhGMpoQYM3MllkCdXt+SNLtb8MC8uPN6
         fsDcao5K2KJAR8ZG7SKm28A69yjo/G/bQ5FrXHQDXmX/yKZR0bXmX1AhQ3UexA+iKtFt
         rx0bDPD12XxN0m31ovwZnq1DKj2b74NiZ+XMWjmP1ZjvoRTJuU62pss9WkyvoB6Y9XvM
         Km2NKBnTn34KArkOOG7IaR+UbM9/CvvcKEHdM78tE//YlRD9L8QbWOSF3Wzquz0giM9e
         RER7rRB45Fgz18E3SrFThPpRSYUm4sG42EIx9+XKsbWo9ojP/2asnpIYSSWEgfTpzNoP
         g89w==
X-Forwarded-Encrypted: i=1; AHgh+RrhRJCehAN6ZtTVA8OQ+b8T3i5DHpK75AY91q9Z9PJC0HNtKGw10NProFbwXhRIxNK1VpFIHVaiQZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsoKk56wxY++fgVIoNoRO4eS2pj8MmhtmQu6Z3YCo/QrSdB5mN
	9pMSElOiMa0rVz9nrHttZAhRV1qjBlUoa6lQu6vgsu8qxdpAsO8sbFebV6tAKvZyh/OleT+Wf8x
	zKH76ubpjRjTY8MjWZqS5pSZLYTaE4hA=
X-Gm-Gg: AfdE7cmDdo6vfgPDm2aJRqTIyIkQXLhby+Me6NGfrIzYlN2s+UPwEFIskD5MbwXUckq
	5mbyvUQjJnncy6Gfk8ewtQ9zuA1oVVM+yqld4cIEoH8G2afviRo75tWitQ83kwPk+GZuiIPAowg
	9KEgIxs+BZJDd5JQ6gm0b6CyispzQgIWxUf0AziatjBi1TY9zbgX8vHb4Hc1K0Du342EzPwhAGG
	oAffdQn8rGy2pGZFCufmaWRqGy0bjj4M1ewrX9b9ssVC2QmuH2Wrp7eKvf3JZ6HfDW/ezuNfXB9
	kmwDb4XU0JtDROuCfaFagJTFMVGf98uOxhvx0uxtsNldrZHwDLVOkpmKEDGcmsZW6VLRP9XknvP
	OCNlsHg9sVUP0
X-Received: by 2002:a05:6512:3987:b0:5ae:b9b3:9f96 with SMTP id
 2adb3069b0e04-5b0115c01f7mr445459e87.6.1783524328462; Wed, 08 Jul 2026
 08:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-9-72cd5d055d54@garyguo.net> <280FBE45-5653-499B-9BB0-A2C77030A826@collabora.com>
In-Reply-To: <280FBE45-5653-499B-9BB0-A2C77030A826@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 8 Jul 2026 17:25:11 +0200
X-Gm-Features: AUfX_my_GxC4KLJmz5i_4DX9QExeJawd6XQyKpw76D3pBDNdQQvLPjQ9qPUqEYs
Message-ID: <CANiq72nyEK7cMphaawV73bN7VmAKG-UOE4SPDWDpAqoLs8zzKQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/20] rust: io: use view types instead of addresses
 for `Io`
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:daniel.almeida@collabora.com,m:gary@garyguo.net,m:aliceryhl@google.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9647-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[garyguo.net,google.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,collabora.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6AC472853A

On Wed, Jul 8, 2026 at 4:37=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> You mean to avoid that cryptic =E2=80=9Crust_build_error=E2=80=9D when th=
e assertion fails?

My reading is that it avoids the assertion failure itself -- if the
compiler decided not to inline, then it would fail to build when it
should have succeeded.

i.e. it is not about improving the error message, but about avoiding
the error to begin with (not sure which one you meant of the two,
though).

Cheers,
Miguel

