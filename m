Return-Path: <linux-pwm+bounces-8396-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Lr4D7i/xmmKOQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8396-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 18:34:48 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7CF348711
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 18:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B95303022925
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 17:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2483F1677;
	Fri, 27 Mar 2026 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2HvB1le"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833553F20FA
	for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632500; cv=pass; b=H0lipdNtNNOVAwjeu3vkzg7Uz7w1lZpvAM/Y4hP/T/xQy2+7M1I5vHgtBldQWbUgu0NGY8GlvvDL+J24FC6rOw0shEkzbUoYydwWfdCftSTCnG2xobzWYF3+v57o2JgEQJflXjRFNjWGuRFeojQguTqygeO6Hl5zEMGwaPIRPY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632500; c=relaxed/simple;
	bh=r07QpEoVNQj/cMLoIqWS+u26NN05SjTYmHOe7gn52aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cw6GdmAHXkGBYAplf+asAmVeLaY+rVgOrr6kA8JrKmfpSPlZ2bJooKlZmqVmH+SB6FIMXXTGfQk6AJMPzZSk+YifC8T4nkFm2vCPW7Vqs4EPQxjkLla+FmQYmIeTDNSL1P3lTvrKVUmYhYYBQLaFx9F/bd765y4p44ZGZR57B2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2HvB1le; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0bf0a0236so79435eec.1
        for <linux-pwm@vger.kernel.org>; Fri, 27 Mar 2026 10:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774632495; cv=none;
        d=google.com; s=arc-20240605;
        b=G4WBtol7eapZIVewY2ZvRK+mvP9MpdRP0rwkXuw1inQRmLo5KZh2nHf4Oz4ymLospd
         +c/+b6SYm8jq7K7FDJfe0dyv7ma0qnBxXW/U6x0iZns8uA/nMBsMVQunOnbV8UoDvL49
         32ON7zOAQSX0mvEj4WWb4OFzUjE3KSZI3aA3DVyUppJ0PwcM4TJR5oWR8/CMy3ffbKX8
         9rd9TByySbXAmmfPdqCT5oFxtnvxgLNAqIlcqlUyGL+3dyhKmY1ewq8CxSlWiuFGpy+O
         71195v2ZKz8Z0cfZQd6DLcvjE8MBdC9qDqyssCwZdiuw4VfTwcNXPO1O8uV8HVxIYzxr
         A0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fl/30Pozrrpem/yafXqH62BWdDU+A3/vTaR/fO+0gHw=;
        fh=aZYyqfeKqImO85GnefsbP9yjP0I5aqqroV66ElV71bE=;
        b=kxH33xSjHiN1R1RdcKnPq/uHgoTlry30AsUw0YcIXvWBoTHyKDoD3dhnOeAWUxY/LI
         DWeCqeWnWbZUKA7/9hcrMMNfyTIsGSnqCkDYlQfveKchLnCU6XfkA5QOV0dDTH/tavVc
         mZpPZJKawTDaiqkv9Mc22Ni++UoCDlrlGtkEgwkrSSnztfmz3B/9vQoXoYlHJT2pRTJC
         cC7hgZ7jfO3szCxBx3Hvs82acgG2CFK1RLrYlb/1PjSD8tTnsNUh9MijhdYzdjRqxL5I
         iEHy5eNH3raRNy2543Wl9HeGEd+XylZDp3JzNuE/V/vzrjPaojTiIEiZ4ObJ2DcnFEyH
         iRog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774632495; x=1775237295; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fl/30Pozrrpem/yafXqH62BWdDU+A3/vTaR/fO+0gHw=;
        b=Q2HvB1lepZeyiEaMLs07wlt04OT8CsRPS6rD880plQuOUNt9ayBKj49ExUeXepWwsk
         hvgdVrpAog+Ve6cMLilo782z+3TBuiCYildMY3dsfmJhY715eDP/mBZuS7uHWD3Dz/ZU
         Y471B8ne05E/vVBPBGBn4DgaQSdJJSR2FDqx8sNucX2/cC8RDk7+UhulCpPriJ4cytxt
         74BIsv5Vq7gn0JugSL5ZmSNHm3J/huRtALxNUyGCk+oPoLBE6C9Q73xJomWXfhZOcapp
         PzRoXRoDIzuWBD3tDghLeJWTiExyXCswxd8fMuQo56yJvDx4qyCMRUjGMzvoZPHvXmwJ
         T5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774632495; x=1775237295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fl/30Pozrrpem/yafXqH62BWdDU+A3/vTaR/fO+0gHw=;
        b=WwFljBAmku62oLxh6gqXgzPbpsKD/A+n9QnFwsr81ykkH0sMLCYABYhVU1ZF+gmKEG
         yNlYwfIjHPCAP5NLJ2lAJBNxe3UpFo7AsRd2v+Sd9y+/9x6Imn7lbXXnNA15gSATAJtA
         40pZ6udT3CgXrPFwDnnek3a5+kItH0aaEM8aaDXvLMpvsQLnFJU7E58j79SLO1s5Fmbp
         RcdhjYbU4hBIQsnmkn3QE+K/FWcyz8SfDunuzBTeGfpyJ3HwAyYXOqvzoTfLSMwuKGe/
         +XrdaRsY9yhx2oPRDI5YmOfTTmltQdIkzLyv1H91N2lZRlcRhE/epLJvUjvsZXiPu08C
         OD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSTT5n6kshdKvPnmuMTSkEVEpLNtkhROpxKk30xf6jciXcI4nxTV/qCxWCPV6cDhCIvebm6cJD69E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhqxsnG+4gzkWJc3dqz6ec8rn7w8PfaPHd46iVupsiuD4YrsM
	z+B4+cKWwRY0mRG1jsC9gWyGOb5pIGqFkiDMjgPafMlcVJfCM/3x03Xvhl4loJIul2i6Wo9igPH
	O04Yzx53V7ljLXC8Gx3Ohqzjt9JxOKOY=
X-Gm-Gg: ATEYQzwsw6p+eiM+Y4VogCi0jnJbFqz4C3zPqVMu5HMLautWhyKIeBQRaGunzv3SKiH
	bFYZkQRA/IFSvxlhTXnuGwjAKMi2kV28gnC99o+6hu6iUOpYI1wmZqTSqI3eUalhX1ubaC5/OdU
	T2aIN0GgtI6VsrkHiv0EiroWwqjELOaIgHhqGYtKyUcOdwefhkE+sRSGdI+1ExUoC74fV4CG896
	7oVwOQH47Xmps6LQ+YzLpGv47pLJh0LQgkspgbKeD0nueNqJkLUG4JabydmYNzJX2pe6P0/CPjc
	N6N6Nr4gH8kG0W2Ef1MVlGq9RF+08qPNhWVNH4KnKR2mHytLPpSoVwTRzgqZ0hQvGluwGMD0cyq
	IJddtuu9ztn7hRqX1hnKZPhEAupULv1EsNw==
X-Received: by 2002:a05:7300:2309:b0:2be:681:91b2 with SMTP id
 5a478bee46e88-2c185f4e132mr930663eec.6.1774632494589; Fri, 27 Mar 2026
 10:28:14 -0700 (PDT)
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
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com> <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
In-Reply-To: <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 18:28:02 +0100
X-Gm-Features: AQROBzB_RVTF4XlQkJ9XF8lid9aR8wXF5WiHOT3rgHJbDAOKcJRtKWbfa3x37CM
Message-ID: <CANiq72ktmUFsdpBUKnU-OvTj7rE5iZKFucubL_1bF1Ws_KYXcg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Brian Masney <bmasney@redhat.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8396-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,baylibre.com,linux.intel.com,redhat.com,samsung.com,linaro.org,garyguo.net,protonmail.com,umich.edu,collabora.com,vger.kernel.org,lists.freedesktop.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC7CF348711
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 4:17=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
>
> I am not a clk maintainer, so I can't leave an Acked-by for you to
> pick this up unfortunately. I've been quite active in the clk
> subsystem though the last 6 months or so.

In that case, I could take your Acked-by as an active contributor of
clk if you are willing to provide it, i.e. with the "# Suffix"
notation I introduced a year ago:

  https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked=
-by-cc-and-co-developed-by

  cd9123eeb224 ("docs: submitting-patches: clarify Acked-by and
introduce "# Suffix"")

i.e. Acked-bys can nowadays be provided by other stakeholders apart
from maintainers, e.g. people with domain knowledge, userspace
reviewers of uAPI patches, key users and so on.

Especially so since you offered to be a co-maintainer long term, so I
think having your Acked-by is way better that having no tag at all :)

Cheers,
Miguel

