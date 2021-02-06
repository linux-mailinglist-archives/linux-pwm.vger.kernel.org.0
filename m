Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF37311DF3
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Feb 2021 15:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhBFOvg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 6 Feb 2021 09:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhBFOvc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 6 Feb 2021 09:51:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F39C06178A
        for <linux-pwm@vger.kernel.org>; Sat,  6 Feb 2021 06:50:52 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so17567405ejf.11
        for <linux-pwm@vger.kernel.org>; Sat, 06 Feb 2021 06:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=HUvGvCtGY1kdjYDgD6lpW2Qf7bq48eHGkMT51HdjUyl1Q3saVcudSp0c1i3BBq/1Zg
         C+XSlY5RgGBf0JKIdVhjDqz6c90al/KKzYwgFTEnMZJzoQv6k/uz3mOeRfUfJvyptZSo
         rt2mKKHNoYB8KM8Rfnn2Iz2FYbqu3pnMIalIgrjWz1NSySdL5xSiMTDxaCvNHXli0H/f
         5bAwohtJ/elMUA6EKLY+312zrcaRhBlQa5admUX383ZbCQlSCdNYH4EndplNNmwDcNFH
         JHSSgNjzinvIXZBAbABWOwGTjbuKFlSpgWuPqHZi9Zcj8EvA0NyPpHy8oR82V9C6EoBf
         Y5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=c69U4cyBsBMQe+vB5uX+qHtQ+/KVp0O1dHENTit6+nnK2NaV91qozHEDdnOafen8nN
         bHByJf88lOu7CYtiqcH8qvDe2wqZEgH6BXGuzUsqryWEETUy78lWqYCuD+CryQ7zjL4v
         07IpObLAva/kTJS1TtTuofU6Nqyk1kwwrnaGFXa2qjzGwnW1VetiV6MpCeMU3LreA6tJ
         ALbPrisk9EBI6g5tyUSxD/do0mhbo5CX9rYcSKQ2ELDvTt7114MVVfqUhjyuuctLOqVQ
         Fpcff4pqj4sUZAxj3WyEhV2Fs+kLnONBeY0Ga4IYcW/ZlY5kmQAEhoXN4IqEZl5IjQ3m
         rtQA==
X-Gm-Message-State: AOAM530sXVo3wQHgucpl1vS9RFkGgMFCAzwn1W2/pMG6JA5zWYMR6rpT
        VvDD6Ve9J/Q6uyjKtmuKIQrwuiyxAGhxF38solg=
X-Google-Smtp-Source: ABdhPJz/90jDhOVD2UnpCXo9v/NihfhmpIdbUdOr23fy8FJi7i6V/ZwRwhT3vRetCXx1UkwFXLeUyyX1bCRH16cT49U=
X-Received: by 2002:a17:906:408b:: with SMTP id u11mr8867883ejj.299.1612623051414;
 Sat, 06 Feb 2021 06:50:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:25d0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:50:51
 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada9@gmail.com>
Date:   Sat, 6 Feb 2021 15:50:51 +0100
Message-ID: <CAGSHw-BDwe93nggkAnVtAhRd4Y7dVH+fZh7mG+JmFXzkDvUQRA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
