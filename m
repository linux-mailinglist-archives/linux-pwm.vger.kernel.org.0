Return-Path: <linux-pwm+bounces-8333-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHp6OVOGwGkKIgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8333-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 01:16:19 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 509CF2EB3A9
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 01:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22A373007CBB
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E2413A3F7;
	Mon, 23 Mar 2026 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvA6/jeN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kPrJ512D"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC2347DD
	for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2026 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774224966; cv=pass; b=TTytXbLlc2TuxkRy1cm2zj1j8+ti98XqJ5Kov8iJFQukiqmjcLPgeN284rWG69JHT40bE1tfS6Hre6Tj9TizZPZPBilENkAeDHN2+XMpgHAoSQA/7WKNnKww/SHL8Mi2+cP7LA3EsWn6S1Jux0/HBPb56XJ+fmkZYGTAfjM+s2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774224966; c=relaxed/simple;
	bh=Mz4C/9cLAOaPCx0GR6OuyCvm178ZaYrumVlM4vEmkDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhrdHC83scuet8AuWS+P/JP1vVdpo+aEyi/XjPo37IX45SOsimNtPqwm14K9CHQ+6SjoskhWfxY6YgJVr9Wj0LokKBkG3wmZLR3yerMXc+1PGyeBmeVrH+wMYWavoqawb0EVxsSszvOfOaKj1IUm4OSSGLYW0PEP64TSMDWhnGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvA6/jeN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kPrJ512D; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774224963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mz4C/9cLAOaPCx0GR6OuyCvm178ZaYrumVlM4vEmkDo=;
	b=DvA6/jeN/F+bukrZilrk81irRXPAKgroaeLO0GH8WjfINB4OzLtMUt/YNewBacu1Bn0+yS
	effV/p+VO2AZ5tq+kAA7cpobvT+lBYa2hkQp0Kgd9dCrceqfBxuKFrAuHT9+q8ls7B256z
	qYCYomjr0ca6prESYeLw4x/hjNtwJbo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Dkb6kBNFMG-fRHFaGaFowA-1; Sun, 22 Mar 2026 20:16:02 -0400
X-MC-Unique: Dkb6kBNFMG-fRHFaGaFowA-1
X-Mimecast-MFC-AGG-ID: Dkb6kBNFMG-fRHFaGaFowA_1774224961
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b97b6ccf166so257233366b.2
        for <linux-pwm@vger.kernel.org>; Sun, 22 Mar 2026 17:16:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774224960; cv=none;
        d=google.com; s=arc-20240605;
        b=O1Aoel2SbVwb0MibE3FQNFawuPlXBicXMAiASHZCR5BgnFUoAPQZxXXUbKJy89TMMp
         lOJccuIc/ImSjoWbaevDxEa+b10MKpS2cE0VxM6jZqoydaksnAKxtSUodBQTcwiHguuc
         OVjjLG+7n+JYpRTS0XMiZMlyvsTt+SDnr2eIk9VFJXR0Wy/X1M10vUiYlKRRTv2Tk0yC
         IqlTmq45b/fm17pbwrpfGRi4Qc1l5zZGUtLgl2bEO07GisxWkpe+P2LrTkYfLeZBF17e
         qfqePam7ilz/vg/9yJcbW4EQkvQw2pytdVObrraZzCygC7sgI0s+RehLirvr/MiorlYY
         fk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mz4C/9cLAOaPCx0GR6OuyCvm178ZaYrumVlM4vEmkDo=;
        fh=wmapNZP8+oGjQr/xo3Oxg9VVniCUeEUuvdxLozX4GRE=;
        b=cRsMhF4lRfnj5SrDEMIko5R73rFrhsea0zueS0+wqP8xQRorvYRqcsBG9aKEH9WLt5
         QahOxKq+GU0EfiqKDq7PuzqDEqFH3NdgzKPura3ungo4OKr0np1Su2SadXHgmh0ef6j1
         PGOf+zBzaD4uYJdQXIXVpUo/vPb9Uiepvel2YNPZtC4vacjX7sPseajaJX04qiqDYS79
         SceZcb2jipp6piuGL7SP+AEtClM1TxR6UUv80WT94qsqe0bG/5EMwBUVlI1dPsrTEbsj
         GZXL4Ye6WpW9QM/x5HpLllPrRzbrg1oP/AO2Yyqthdu+/Y5i3Q/YVBd1o9OKsT6JZUy/
         NRkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774224960; x=1774829760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mz4C/9cLAOaPCx0GR6OuyCvm178ZaYrumVlM4vEmkDo=;
        b=kPrJ512DRSW+J5WctURRy9dMghkGz0dHsmyRlP2W98rKK58/R9NG9SnVjA53wbggWh
         IKxmS8xORlnZzEx6D/n7wxKNUcGugQgJhImx6ICsKq8RUwQA/sH1zS3kVlcuXb0ooIBO
         IRoaAVPpHfipPBLNLzDAIPkrqmsi9pbaAv22ekD9XWw5dHdqXojkI7ljzTtSjeGQ+V1u
         LRMNYQYHLOiJNS7+3t2RNBvmtinwoRJRdmtAWN+BcySTs6sSTT9pzvlDpbirshpE70qi
         x2DPgZ9PDptYiSbdVtW+VpsCsWTWFlhJW837SQm+JWX0sd5OtpoA5A2bwoB3IaCrG4PW
         7KWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774224960; x=1774829760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mz4C/9cLAOaPCx0GR6OuyCvm178ZaYrumVlM4vEmkDo=;
        b=X/CoceoxOUjvrUVxpici9AJJAkDE9KT3aCT7tyvetQa/xl2ps/LUfZIGTABjGWlBT4
         5F7cFI69ZPCid3kIKvZ27dufd+8TIecgBgBX6HQ2knNKcWkNT1yMQTCDlU+uH8BTYOHs
         qpwFiCPEywxDwcpurZZ7TWLTD78wKjEnEl9e8/4Si55oVtfEIDilfnhPlXiUZSDgIi2E
         /TSYd44Y4YJw2NvLpCHFcpXUHv98hYV5pzIK8DKHXrZH6pg2HhEXr58T3/lzDfg3oBVT
         g3+MWWm1q1Vw791UNq605xCAu9jAQehbMzhYmGfmrzsSHgT6F2eR21oBeN1QsyG5/idG
         6qwg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Jvz/DwI3gztWJf11rJnJ/XyOtsV/IA95cRxQL0IHdjrerLC/zvi+qJBjBwkKTIeWov3Eiestu1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsEvzzpM4c38Q47MUH4L/6fJGxTpJnbBkLkbT8aqvRkG/JX1e
	+JOpRcGrVMbSetlAQln6nPMhhC4wRyzYIavtdf91lTD9Z38UVNyyVBYSBA3u8lA79QyY8VDE+bk
	fAeNUehnmqS7VgSTcxwII4lqyUMlSWCoK+W29I6OKlI4Zb4vBz4+fOqJ/6580rhc5NxoMjLNBaL
	gxli29q/uDkfLSaWXcKLyzN9VqX7bISlTLKRfv
X-Gm-Gg: ATEYQzzjBH8xQMBzHztY3If6R84Z3SC/U+opNiKyhB/+6nTen8WIgvW53/xpfwvWzLn
	hEvIqRpquUQ1JHJ47+tC7Bb1RDprb5RZdpBtYqXLLffVAZzD9ZFjqxfpRVNBo70pdsfI361JXQO
	Le81q71Ozrr8YlTPiWL5a+yAGjYCGZfQZl1sJFP3e2gYKxZ/u7sv1iDYbke+3MTlQKJfIKky63i
	6udug==
X-Received: by 2002:a17:907:cf8a:b0:b98:32c1:246e with SMTP id a640c23a62f3a-b9832c15bb8mr715930966b.8.1774224960441;
        Sun, 22 Mar 2026 17:16:00 -0700 (PDT)
X-Received: by 2002:a17:907:cf8a:b0:b98:32c1:246e with SMTP id
 a640c23a62f3a-b9832c15bb8mr715927066b.8.1774224959860; Sun, 22 Mar 2026
 17:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
In-Reply-To: <20260321-awesome-hot-kingfisher-5d9f55@houat>
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 22 Mar 2026 20:15:48 -0400
X-Gm-Features: AQROBzAoTifV84Es4roNHZ7fg_jcFEWRuoYT-h9cCD6210iyG8-nf7F7j1kSz9A
Message-ID: <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Maxime Ripard <mripard@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Michael Turquette <mturquette@baylibre.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Drew Fustini <fustini@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8333-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 509CF2EB3A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Danilo and Alice,

On Sat, Mar 21, 2026 at 2:17=E2=80=AFPM Maxime Ripard <mripard@kernel.org> =
wrote:
> On Fri, Mar 20, 2026 at 12:43:47PM +0100, Danilo Krummrich wrote:
> > On Mon Feb 23, 2026 at 11:08 AM CET, Alice Ryhl wrote:
> > > The Clk type is thread-safe, so let's mark it as thread-safe in the t=
ype
> > > system. This lets us get rid of hacks in drivers.
> > >
> > > For Stephen's clk tree.
> > >
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > > Changes in v5:
> > > - Rebase on v7.0-rc1.
> > > - Pick up Reviewed-by tags.
> > > - Link to v4: https://lore.kernel.org/r/20260113-clk-send-sync-v4-0-7=
12bc7d94a79@google.com
> > >
> > > Changes in v4:
> > > - Pick up Reviewed-by tags.
> > > - Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0-e=
48b2e2f1eac@google.com
> > >
> > > Changes in v3:
> > > - Rebase on v6.19-rc1.
> > > - Pick up tags.
> > > - Add fix for pwm driver as well.
> > > - Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0-4=
4ab533ae084@google.com
> > >
> > > Changes in v2:
> > > - Rebase on v6.18-rc1.
> > > - Add patch to tyr driver.
> > > - Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1-4=
8d023320eb8@google.com
> >
> > Alice has resent this over the past three cycles, but it hasn't been pi=
cked up
> > yet. Please let me know if there are any concerns -- otherwise, I plan =
to take
> > it through the drm-rust tree in a few days.
>
> Stephen hasn't really been active lately, but Brian (in Cc) has been
> trying to pick up the patches falling through the cracks. It looks like
> such a candidate to me.

I'm planning to send another clk pull at the end of this week and I'll
include this series.

Brian


