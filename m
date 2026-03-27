Return-Path: <linux-pwm+bounces-8398-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMfZGmTCxmm8OQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8398-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 18:46:12 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B832C3488F4
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 18:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB82B30FC2DF
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 17:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FE03FBEC2;
	Fri, 27 Mar 2026 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhTpD8wo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfLNUv+l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387D3C6613
	for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 17:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633152; cv=pass; b=YVS2C4ikoRa0zOJEzNH2Qa2quMoQMDwrBiS5IsM0XRNpmEWdAxIbGRyXxqzfCCe1VaFywkEQmShZi39VyrlzEXooXHcH7vSDQUGkvFWMZckXFMgl4egR4lrm06PRVd8m6sCLq5/RPGTjy7MwNxSNCfr2dAxa+As14bnvzUk+O58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633152; c=relaxed/simple;
	bh=bT/y4JBqDvjHUf3ohN/Qg+bpv5VC56Jq9Guzemu4yO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XLD2CqC9NkUO/4vL3EsSmxtcdqh0ffD+5psQ9AMQ9fr8xP2MmCifZgihuM5evY7MRNTQnMgD7WR/Ezq6MmFcwYKri0giXkv4+u4sEHrkkz3665+fdBp6utwT5b2ZbWloadUtp67si+YHtov49Lfx/vJH1UFw67sURondWphqDFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PhTpD8wo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfLNUv+l; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774633150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhPdolAuW7P0xgBhYuWJf3nGp5Pv13lQ9qoFlr8i+xY=;
	b=PhTpD8won2tO1Uf57i9PK5u3Zi8cwkZzmsxIO6o0wc0NT12S23ZuDQ8ARTbvznZZlJFiPl
	zGWFiTu59DMg31z7Dt5AgJNdtwbZSoKVy7hL6rbm5Q+g0c9lokS5f8S+5eKa0oNNBpfo6X
	0Cc6rBbmBUhCZTyjYappDwmQ54TmQ/M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-snaEQF-MNzmjtvPglWPHCg-1; Fri, 27 Mar 2026 13:39:08 -0400
X-MC-Unique: snaEQF-MNzmjtvPglWPHCg-1
X-Mimecast-MFC-AGG-ID: snaEQF-MNzmjtvPglWPHCg_1774633147
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b940da8ec09so159600366b.1
        for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 10:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633147; cv=none;
        d=google.com; s=arc-20240605;
        b=a0r3NeVWa9XPWmUmG8BJ3wTCOtg8xSWW7CGX4rOtKvsZrdtnGEtxOoK1K9FFLUG/Fy
         4mcID+DE46sAtDBMFOLo+18VrGpfjOgbyCLIKqTs2d2ACcJFb188BOdM/A+vBP8xYisN
         1lb1iSCLxGMDENGzT5pQDfZF1UPTSPk/CCl6c9nblO9eP+UQ4oeWi5t2Dul9nYJeyRYK
         q0n73ChjOAZBmeE3bMSUbo2oqRRNo8j1y5yb8JMVLfL4Pu5NTv8TO3VrJKD+wT0BbEDa
         kXr02nv2jbzBt2B/tr5w09th5DWn6Tx01Ng7SYtdiK4oxjHQdXwwLdBPtCs3Iv/INJKr
         /8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GhPdolAuW7P0xgBhYuWJf3nGp5Pv13lQ9qoFlr8i+xY=;
        fh=o/QcCu1ANNNY7WssCHNtZSmRuZhYLsS8sLJVH+wIdKE=;
        b=Wi5itrA+4QB/LvxOO5Dxbt9bHyrbc5rP1JfdmNXtQaNUFn67GhNHCGE388VVyb82Jk
         61uF2Fjcsfwo+s4thAStmIx6sgze9OIdRFnHrbwJBemKXOK5n9K1SNnsT7gq7MNqTiGc
         yy+uKMn75hmGU5suan9tH7j+F+o55HtPGj9eLtWNuzmZEN+gYmyqCaotdDp16fjpZiWk
         48Xaav0eh606/ytgVawhiAymzAIvrOC3ggXhIgdRv1BwkLkkvUEpGDlOdjQhZ+MvA8Yx
         +EbwYyoxvWt+K2Ro7K4rBYfUugbZwKu2sYfN1Rs90iko5mjKcO/YJ+bzs3NG0abkE1se
         0Rtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774633147; x=1775237947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhPdolAuW7P0xgBhYuWJf3nGp5Pv13lQ9qoFlr8i+xY=;
        b=QfLNUv+l6bd/rbCBbdR63db+q3fSzJXvWtQ9g17GwqT7ntG6Gtqgv3QtRKfXJvzP9Y
         LjmAEVdCl7ujtlsZs+LOcN38Z16m17N4xMcCkJr/WF51ujRuCeYHXVmtVBGgomgCry6m
         kGaoVlUqZMPXEtGLvadt8KdP5prj10OT9rNefvm49mi06f1I7BUcsiOGCnzjDCCVvhyY
         vPa+fWAvH7vE4B9J/FPcSs4/gkisXqCh/phHT3l2x3Lfe20TSjivXZlOqK2lJp3OaBl7
         T1z+nx5O/DbwLAK5/7LpSsk81sNncM/F/vzTLKxJmsRK31r8jTqeAb5cxJUs7X9FTpx2
         KygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774633147; x=1775237947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GhPdolAuW7P0xgBhYuWJf3nGp5Pv13lQ9qoFlr8i+xY=;
        b=mwmpjmTu86FlC1hu1n5pZpWGb3t2kWJ4UDgi/19m6nLBoBZDIIR27SajYI74adQAGe
         pmevyAEouUpUxLDZSGFXbR7z1ErUq7ZFrttpMfmmPvD6np29qWhis9gRbe3kLa4IhBd5
         hQgYtkFfYMcsmb3venZG9oOOVkqQWfYjWbLncBZMSMPXv+/324S+J27ZVuLTumfBVgm/
         vn2EAxiBun/bqPe2Q0GCL0XzuRG8W0aRH+lMhHDiD77KgXNMzXHPfzAp0z7DAucpIoT4
         PiVTPiH/1RzjAtzVmjIufXIEkS6cVZX3Em0OFxbU9zhYyaDtqs+4n6jL4UHL30WmDM/R
         SVwA==
X-Forwarded-Encrypted: i=1; AJvYcCW5cW7rJyMkc5ljPTiM+OmeOxMOt1jXHciMtB6brO2o6zic9QMGWOyqGHiFvjoev1o7KXsoCW04Ars=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhcmcIKKDmM+sSrMQDYkWpL4puKpgwe3QZI4/q+IOCOMsH8HO
	qrZEpAp/xposYHCjsn8QzSx3IUztwvhcQhptlmc0yww3jmerpXskMDxdH+WMqlCtNfYiM/WUkDg
	Uq5DE0VY4ZM/QUdwnj7gMhH8LsOW9qALIwAF7fRa1BCHzpaTL4x/3gwUmzKjmNLEBOklnmQSWws
	5IHfDgu6EzLeXATC4S9FU50P9H9Yh9OWcATHYA
X-Gm-Gg: ATEYQzxw32AzxfeDthRUtPrjHW5nm+Q7ckqbLJKNuY5EC1Ck69Lf1OlG3OZlbIYHal9
	kPZrIZF7wGp88Sedgl0NMpYKvJnGMHJD+9cA/1oEdSlWJrJMRbAr9XNsJaY2Ke7b0ScWMdyTuRE
	BmQUIlPxm5cuVjwvNtOKLzk8tOjb8eOXGfd6ln8wuHiz8bjpEXQHXq73nh4+3PGD4i02Wg7+8ZZ
	b4HrQ==
X-Received: by 2002:a17:907:a28d:b0:b98:22e7:72b with SMTP id a640c23a62f3a-b9b507a7bf9mr218779266b.30.1774633146700;
        Fri, 27 Mar 2026 10:39:06 -0700 (PDT)
X-Received: by 2002:a17:907:a28d:b0:b98:22e7:72b with SMTP id
 a640c23a62f3a-b9b507a7bf9mr218776066b.30.1774633146199; Fri, 27 Mar 2026
 10:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org> <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com> <CANiq72ktmUFsdpBUKnU-OvTj7rE5iZKFucubL_1bF1Ws_KYXcg@mail.gmail.com>
In-Reply-To: <CANiq72ktmUFsdpBUKnU-OvTj7rE5iZKFucubL_1bF1Ws_KYXcg@mail.gmail.com>
From: Brian Masney <bmasney@redhat.com>
Date: Fri, 27 Mar 2026 13:38:54 -0400
X-Gm-Features: AQROBzB7WfnAtTWMTsWRSmdXifxpUbNDAg86GKrLb9ikVgnMGrHcwDI5L3K7rv8
Message-ID: <CABx5tqKKHvFPYrL=gjaOn+frDXfXpxM3-6oTzSo6QVgYMaEMPg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8398-lists,linux-pwm=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B832C3488F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 1:28=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
=3D> On Fri, Mar 27, 2026 at 4:17=E2=80=AFPM Brian Masney <bmasney@redhat.c=
om> wrote:
> >
> > I am not a clk maintainer, so I can't leave an Acked-by for you to
> > pick this up unfortunately. I've been quite active in the clk
> > subsystem though the last 6 months or so.
>
> In that case, I could take your Acked-by as an active contributor of
> clk if you are willing to provide it, i.e. with the "# Suffix"
> notation I introduced a year ago:
>
>   https://docs.kernel.org/process/submitting-patches.html#when-to-use-ack=
ed-by-cc-and-co-developed-by
>
>   cd9123eeb224 ("docs: submitting-patches: clarify Acked-by and
> introduce "# Suffix"")
>
> i.e. Acked-bys can nowadays be provided by other stakeholders apart
> from maintainers, e.g. people with domain knowledge, userspace
> reviewers of uAPI patches, key users and so on.
>
> Especially so since you offered to be a co-maintainer long term, so I
> think having your Acked-by is way better that having no tag at all :)

Sure...

Acked-by: Brian Masney <bmasney@redhat.com> # Active contributor to clk


