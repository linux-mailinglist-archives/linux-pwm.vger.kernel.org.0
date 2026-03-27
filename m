Return-Path: <linux-pwm+bounces-8392-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJF8MFOgxmnrMQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8392-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 16:20:51 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35661346A09
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4D5630795EC
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD66330D2F;
	Fri, 27 Mar 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRXmFpZ8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAcajNhP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67232F748
	for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624685; cv=pass; b=qijJ//6Nz4/IWkXGl3oUtZFQZGgoNpwDYTTebFXtVPZBdcUGuSA+JF7FVN+0kGQmfukL6igyAU6Y+YIbOP3HbTNfZNwXR2fZaP8m9ksXUFiKInA7GZW3iGxMKaoo1dKbjO29VktB6b+HfF9ysDkMj0uN0rsXP89iyN7yPRYvMf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624685; c=relaxed/simple;
	bh=N+FUxj1Gl+zVCUHvFBWeIGI6C2A3mF/PTd7CkfeomPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpePifqvUYJN4NHeqlH7zxaFZ8vpzCN7Y3l+MDf9nSvxNn8uBEGfChF9ZAgCXbFzEqatmX/0QffGcOCgQ4A/70u0Mf7PTv2czdDGbMoLwnkDNZGbAtkgaMFt/yObbSEzFb5I5Cna2SMIUS7+o0yYeIVgEujuaOnvsifdauoW0Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRXmFpZ8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAcajNhP; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774624680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+FUxj1Gl+zVCUHvFBWeIGI6C2A3mF/PTd7CkfeomPo=;
	b=eRXmFpZ85BhKu8LvFdzK/LWUf5LNs5glN+5KjOgdeHnRdSJAYxSPMWrKbGYcrNbC0vJct9
	i6tEsuuhcTFqnSO2U0Ga35jddX7oPJZlchzQCpg4Oc+z5JKoDbYbLtF9iYT0ZuZdCus/w2
	uypZmM7vObYI6Wwoiov8kZZr5q+RqTY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-j09VF9jHMO-7pIU6PiHpyg-1; Fri, 27 Mar 2026 11:17:57 -0400
X-MC-Unique: j09VF9jHMO-7pIU6PiHpyg-1
X-Mimecast-MFC-AGG-ID: j09VF9jHMO-7pIU6PiHpyg_1774624676
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9800aa2787so196856666b.1
        for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 08:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774624676; cv=none;
        d=google.com; s=arc-20240605;
        b=Jr8tzllO9DSbDa/bQl7O8sCKSvuuZSbguV8AbTRJXdmqIDRhYz+SwZG23DBMU6ooDB
         aanaWqpLpLdwPLa0NB6m+sbrRXYPZdXCOKWbIPLWqVyixF1oKr6AzyCbytcZjsJDqtTa
         vy/LkCaaP8Tw/mODZp/MxFj8D/DoXu5pGV+M/OB9Dn4dkznIoUCYWwi8jsNKYGzan80k
         k36acBfozYeISrTQL7HwqiYTVeiKR8BMRsx7lmFDCUW30sITgpTJbiFe01FT4e4uLm9j
         IvXbyoGz0RsVsNKvP3PFAlHAlQafyAjM8fePr13zMmgQqwcQm3Li2McQIiIP9mvqFuPx
         apPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N+FUxj1Gl+zVCUHvFBWeIGI6C2A3mF/PTd7CkfeomPo=;
        fh=V8En0kd317qKk2diwQ/d7dB6DMW5Bg5q2JtW/EAztFo=;
        b=hJyfahQku7a9zW+v3RaIthEN9IdHbTDi2lUnISNfiK5OuhOOw8DHafbbg6RYE14OjW
         cc2wsnnOZBFurm1nsJJv9NWHTsUf520dkF4BfaHfo2c7BNR4z9nwT3a1vxrc5yHo0Lc8
         aRsYuMRo/mdnE9QMBbzUUM4Bht3TPXO6DUJa8c6pmyXr9ikrSzCXDVtxywfAXlK8+TcE
         DMZCVKIJxRgykT4C8zWT/Qfz7SATAmKdqk7PcuwcS5qkqEsdUj/lMzql4B+w5gwo14Yc
         W9aX97BtDxX+Mp4Vqch0BnZ1tCWS+HBrB93uxGYw5lkrcTVbTXcuE7hrjPl3CvIMsP12
         VldQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774624676; x=1775229476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+FUxj1Gl+zVCUHvFBWeIGI6C2A3mF/PTd7CkfeomPo=;
        b=gAcajNhPcQfkyvK4Qc02qz/7Kopjequpi0qsteYfPNlILbxx0o2CnToWDSoUq/ggj1
         8TONcafxAaeqcnj6as02QIWHyHcvgruQMRl5owzPmg3dSzvUvNsdZTVnduu+bqDnc79f
         2qWst275DnOmLfWYVgGPhKHZSeQVMtQodYxyL7z6xRaZDis1/BzaW8AeiOLpGFBzdvtM
         pcyJrIcLacOx6gBRAmt+I3bcmc+u0iLrhUvd2VnqrUbUiuMs8KITWYxW3aZOdyxGZ/+Q
         puS75gcwp/L1tTtv1GzsM4xfCW13OlvVjTN0rJTHXambgfGtQLnQHinDy042fUEg8AjR
         aUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774624676; x=1775229476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N+FUxj1Gl+zVCUHvFBWeIGI6C2A3mF/PTd7CkfeomPo=;
        b=IhjG+v+37boQGnUTzbYlAyNmYsJgYzppaYN2TClsqpH8MHrip1kOGtP2nM49bXwFGf
         6vU8gUssmVdIzPsg4lFfj0eVn+cvGlt2tztcRDVA0Wuaald61UCWewYYXINfnLTLD8j2
         tvDKsk+BLWtOo/yrQyVXLqn+aeGysZpFJEW8Z50zwV2mQuj+kXxejVSrVYIMmxD3Pdm+
         cpKdVL2wLgQ4dnsLqSOzUM996Ait7l3d5CyRKpNhTXWgpWQlPoGT4OlItQtejuCmENM3
         vPGnlZ0E0CW/VyFy++hHu3BGrzJGXQySZcVQqwywpwROaJorPXwFA1TiO/afr8PoMeSM
         rWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvqzlN7x3gOF7Q5ldDUVGwRv/CD7yGbnKvNhTAmLTg/dBtmrcyMnDM/zF+wb8W5SIdmpwmHnfP8ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YworPBqaERDtFuXqyjyvyPNsGoCQjBw8MCAake8FwdRei+zHGbi
	a7sqx0wgPQHk3Ny9XoXwQOu1oALXw9HvcXgMCupYdLRpSiOccZjz6Mrgpov2RJllSdHUkcOEWDk
	qBchAAbAsPFblfNWpjWIh1qs/HDDS84SFrKhAINSPnfrk3IPGRYX4mUdQJTc7b+WrYBg3q5EYmy
	El4VE2zgTuMOW8/KYcpG1kLvXl+C6KPyHiLgJ1
X-Gm-Gg: ATEYQzxBx0YxDMbEnG0qH6ZCaTz8SE/yLqLE2qyu7nT6oWm5VHTIqR19cV9MJ9qVwiq
	cLYjBeUfxlDFL57gFUKW2T9YZ+dMDTjlkFYo32aDEcqI1j59zkv0+6V5wd+SznN4+WlJCdnT4PM
	LNd6T4QNmA2mwBdW6bVvNEJq6o9P1mxl63iljfFtH4vu27310GTLUOLBWVa+QGBFlS89gI72BJY
	OMDyw==
X-Received: by 2002:a17:906:c112:b0:b98:36cd:7e14 with SMTP id a640c23a62f3a-b9b5095329cmr217770666b.42.1774624675978;
        Fri, 27 Mar 2026 08:17:55 -0700 (PDT)
X-Received: by 2002:a17:906:c112:b0:b98:36cd:7e14 with SMTP id
 a640c23a62f3a-b9b5095329cmr217766666b.42.1774624675436; Fri, 27 Mar 2026
 08:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com> <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
In-Reply-To: <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 27 Mar 2026 11:17:41 -0400
X-Gm-Features: AQROBzDgpgoaKrafOSYhxekTKjnPTVIaXvtE8lmpvFqxHDMdDYL6dEArDWvsT-E
Message-ID: <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Michael Turquette <mturquette@baylibre.com>, 
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8392-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35661346A09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 11:00=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Fri, Mar 27, 2026 at 2:19=E2=80=AFPM Brian Masney <bmasney@redhat.com>=
 wrote:
> >
> > Stephen came on the list and started to merge this things this week. I
> > was going to collect up more patches for him if he wasn't around, and
> > intended to include this. However, since he's starting to collect
> > things, I'm not going to send him a clk pull today.
> >
> > It's up to you if you want to send this in via drm-rust or wait for Ste=
phen.
>
> I guess it depends if he plans to pick it up this cycle or not.
>
> If he doesn't, then it may be best to just go forward with your
> Acked-bys -- Danilo can pick it up if DRM needs it in their branch,
> otherwise I can pick it up.

I am not a clk maintainer, so I can't leave an Acked-by for you to
pick this up unfortunately. I've been quite active in the clk
subsystem though the last 6 months or so.

Brian


