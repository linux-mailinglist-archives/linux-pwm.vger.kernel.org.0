Return-Path: <linux-pwm+bounces-8389-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHRBFGeExmlALQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8389-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 14:21:43 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CBB345122
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 14:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F3353024941
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 13:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722843F2111;
	Fri, 27 Mar 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qhpsnojl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF1+1Od+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093C43F20FA
	for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 13:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774617564; cv=pass; b=arZ1dwd3PV06lfKKiqEjYYJK4jW5XG6PgARoaXHHVOjaE/qDrqDekTZz6jpbfY8oUD5eUZ9vP5PTFaM+QdMdibZlhzxmSFKyflE1WdeErpBnNzHIv6QmjUPDf2/5kAvvJO9IciC4kIghzGZe1rXRKpBeZwBF9WNugzY4G+o6Zw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774617564; c=relaxed/simple;
	bh=O7lSs+njbRqVkVDMgsOfygnKLYu8xaGMK8nVUk8tZOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sHip8eVSbIeVj7T/jZGhnPdaO8Rbn2wc8NjCbdoeklHQL1UqETjJLz9fBQ2rgXIoULa4nTtQn5HkR7KzN9swmiKYXE6Ii0MqnRR9oT+ce82Rqkw27d0B+eOYihcN8NesRaHdvwFw8VztL4XR4sW5FSVT2Q68a6kNg3B23bWHeOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qhpsnojl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QF1+1Od+; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774617562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O7lSs+njbRqVkVDMgsOfygnKLYu8xaGMK8nVUk8tZOs=;
	b=QhpsnojlFuqiGOokjxFbweLSJ9ox6LapcjREga4mAN61Xt+stDmHSZf8PgImmsW9O0unr5
	kXPB77M3eVDk9uDdWs/fYC2iXHnb/4hG1vUrP5474/nFEeJ6lMJgwH/4wDs9LJshsfc3TV
	LOGC8sBrGtboCscYR3imd1I5a/Y2UY0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-u-jAJRZ6OuqJP3IQLlpEew-1; Fri, 27 Mar 2026 09:19:20 -0400
X-MC-Unique: u-jAJRZ6OuqJP3IQLlpEew-1
X-Mimecast-MFC-AGG-ID: u-jAJRZ6OuqJP3IQLlpEew_1774617559
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b938cb02038so241211666b.0
        for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 06:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774617559; cv=none;
        d=google.com; s=arc-20240605;
        b=eMQyius6fn5SZ5bz/4e0sA1HF8KF+IhO3gaJ1K33MNEDMi819E+nSwFTVWKZuyi7Ja
         n2GXuS7tMASiZD+5i5s7pKl4u6+guKhAUyES6I34QuQyWEf+0j5iHwVL8OPHoik3AQj1
         d4QakhGrkklkpCdpori16CTB8pO4NuigBPyQUljvJREC/bNHJg8pJ3PqBbTl8ubD/PFw
         Jr+Ab54w5W+AWl3kTkZVwN4r5l+J0VmIO9URmHTlGL37AFEjZs+ImgoUft2AzaEWzr8I
         zDrswt08Cac7ee6Dzq0Y18pR7yhGbksrgEBDatE4dqmvDUxEr8Z++GxHZnlwmD1NzkXq
         x+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O7lSs+njbRqVkVDMgsOfygnKLYu8xaGMK8nVUk8tZOs=;
        fh=Kyjd4dSMaBKblHs5ovl5zAfk1uSG7qWYHawiPAfeAHY=;
        b=Y1ZHesPbELu5OQc1vtjIfUeFsAC5/VjM5Mm771q0XBZeEUjSbaQIqoyTIFctHrwish
         7e2ofEiqnFR0Bq0bcPsfaK65DV9cjfAMxxfBOp+eW5Iz8oJocEZL0wVpMJVgN/kStZly
         fE7w+6u4Xi6ws7mPKCJh8BD1wgxrPmZaNa/roF1YpqafBundFElIeak736Mc+Nmy+ZNq
         sptgUMaPEVa8zKAFA3/GBgwH7Z8TuVnwZ+qNnomg+bpmUsZknoX9cAv9Pq9TQw2fsi0R
         OR7HgQyw0e74fnAzM44hc4B4cLPN0xp7s+gad01ML142LTVgvCWyPs+7b+wFfTG4e+/5
         o0lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774617559; x=1775222359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7lSs+njbRqVkVDMgsOfygnKLYu8xaGMK8nVUk8tZOs=;
        b=QF1+1Od+lu0v6SXLoUiWmfc2wQaHF6IaeGlzGx8vxaU0KEjgbLmsWHS7kdZuM+6E6F
         2r/zqBez4/G81iFb1QukUYd8Kp7anbhuxDbMomI95RydsDay+zMi81xoLhe8yDZrfSMV
         yF35ikU2/jwXDHO2nSpPkaV48yNOw5gVpZkNzDPh5tT1Ylf6s235SUG4bKoQniobmInD
         GEXOMMilSk4M/XAvwUNN/TrmMUGPVydz2CngdMUTeJ6m34SvRsq4kM1l/2BrB311wAo/
         UXdPA6MfmBWMeEU6YBRG73otnf8f6MTEfU7vU87hZMM0oFzq6nYFeNR57KHy+5GJ++bp
         V8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774617559; x=1775222359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7lSs+njbRqVkVDMgsOfygnKLYu8xaGMK8nVUk8tZOs=;
        b=m82aQMz15nkF2BJEPdqNBNcNfC5kbqTjNy94mv19jEzOmSpAObwelH/afbRGd3Qytn
         j3rkSIGs/RMEK6jrsn5JBTez3kS9Bvp4ESIyI8AULW2xKjkIesZelJJM/4Q4VnSoiqBE
         3vgueXnUzt6ekbk4fMIts8RvbdYzjZ8tMmoE7Yi5yvICjHXSaZV5azsLUPdHGObxO5bJ
         xDAl6+zYPX85YD22CGlxBSMsmsONNdcUbFstGhCHkuD93mf3eUgvZ3Kn+o73b4Sng2Mq
         vqNS871kkD2s6GVaf9AsHwgDfoEO5eBFcPRY9eh8rid3Cdko/wwIuTk+s67OWXu293yl
         inLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8kABdLtT1g0gSgg1x1TShA8IRHJAHJj2N4lVnQ4rcN3j3KR0Ci+SBI6P+c5pOigqkVl+tTF28wMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CLCWUriRaRXaozBRKqU7flhuZo/ieqnRWKxSuAeKX5a9RBMt
	w4tUGc3/IVloJ4O0FGroXppN0JuYwOky4aX/Z1G3zWD/1wiJzYsuMkx4vVBFSCzokqqH8VTukxE
	EiPH1zusWXKyAIs83a25coSAcOQTIw+wso2Cfml4H4AvPRczh+7M2r53+JZfOIejAEgGVrqhaPJ
	x+9UbvPqn4PvauPYUFNBIJfmt/Zq8BcShcKEcXRVVofCLhUUo=
X-Gm-Gg: ATEYQzxrxAZK58u0su5E84dILmis6tOXhJVVkuu0CEZtn6zt8ik+30EJsWVA2Ds9TJW
	KNUTYskH6jzxlGsbNwc1XDJGCV1OLYuAhC7Av120KpdVaeQyLuEedLe6kpD7ry10F11TCmSob7O
	8wofrQXa9pnlpALHEFyblLoyu9dNFdZMnuG4Eoas9Rkfd4BX16g2MDjqHL7Re2aRoOAja9o4HUR
	8y0KA==
X-Received: by 2002:a17:907:9808:b0:b94:82e:55e7 with SMTP id a640c23a62f3a-b9b522ae87bmr156856966b.25.1774617558585;
        Fri, 27 Mar 2026 06:19:18 -0700 (PDT)
X-Received: by 2002:a17:907:9808:b0:b94:82e:55e7 with SMTP id
 a640c23a62f3a-b9b522ae87bmr156854566b.25.1774617558068; Fri, 27 Mar 2026
 06:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
In-Reply-To: <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 27 Mar 2026 09:19:06 -0400
X-Gm-Features: AQROBzBLIY29Yr2X6VCTB1TmB9iOUiQz4yOfIMWdESx0Gr_aeFF6e9jfGR2ISWk
Message-ID: <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-8389-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: E8CBB345122
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Danilo / Alice / Miguel,

On Sun, Mar 22, 2026 at 8:15=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
> On Sat, Mar 21, 2026 at 2:17=E2=80=AFPM Maxime Ripard <mripard@kernel.org=
> wrote:
> > On Fri, Mar 20, 2026 at 12:43:47PM +0100, Danilo Krummrich wrote:
> > > On Mon Feb 23, 2026 at 11:08 AM CET, Alice Ryhl wrote:
> > > > The Clk type is thread-safe, so let's mark it as thread-safe in the=
 type
> > > > system. This lets us get rid of hacks in drivers.
> > > >
> > > > For Stephen's clk tree.
> > > >
> > > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > > ---
> > > > Changes in v5:
> > > > - Rebase on v7.0-rc1.
> > > > - Pick up Reviewed-by tags.
> > > > - Link to v4: https://lore.kernel.org/r/20260113-clk-send-sync-v4-0=
-712bc7d94a79@google.com
> > > >
> > > > Changes in v4:
> > > > - Pick up Reviewed-by tags.
> > > > - Link to v3: https://lore.kernel.org/r/20251218-clk-send-sync-v3-0=
-e48b2e2f1eac@google.com
> > > >
> > > > Changes in v3:
> > > > - Rebase on v6.19-rc1.
> > > > - Pick up tags.
> > > > - Add fix for pwm driver as well.
> > > > - Link to v2: https://lore.kernel.org/r/20251020-clk-send-sync-v2-0=
-44ab533ae084@google.com
> > > >
> > > > Changes in v2:
> > > > - Rebase on v6.18-rc1.
> > > > - Add patch to tyr driver.
> > > > - Link to v1: https://lore.kernel.org/r/20250904-clk-send-sync-v1-1=
-48d023320eb8@google.com
> > >
> > > Alice has resent this over the past three cycles, but it hasn't been =
picked up
> > > yet. Please let me know if there are any concerns -- otherwise, I pla=
n to take
> > > it through the drm-rust tree in a few days.
> >
> > Stephen hasn't really been active lately, but Brian (in Cc) has been
> > trying to pick up the patches falling through the cracks. It looks like
> > such a candidate to me.
>
> I'm planning to send another clk pull at the end of this week and I'll
> include this series.

Stephen came on the list and started to merge this things this week. I
was going to collect up more patches for him if he wasn't around, and
intended to include this. However, since he's starting to collect
things, I'm not going to send him a clk pull today.

It's up to you if you want to send this in via drm-rust or wait for Stephen=
.

Brian


