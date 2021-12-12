Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8415471787
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Dec 2021 02:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhLLBZ3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 11 Dec 2021 20:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLLBZ2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 11 Dec 2021 20:25:28 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A70CC061714
        for <linux-pwm@vger.kernel.org>; Sat, 11 Dec 2021 17:25:28 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id y5so23252318ual.7
        for <linux-pwm@vger.kernel.org>; Sat, 11 Dec 2021 17:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=W3a+UOJsNc9ZqMkKYG+PXJQrvd2n9lHBewMUav5hoUo=;
        b=qXE1eOiy1+fTZ4qdWlCw8Mh15pl1nD5A7sg7U5uBhmMVwJbT3vgpbDBt9r5OXvIyjt
         eOh1hZCKu5dXFKA3G8vmkDdQezxmOHFpSHOlX/ZguhRZcNv1vO1zzzoBMlRiGvPWaH7f
         NrUWpx4rI0a/s6slbMdvJGNFc08YX+d3kgA7bUIRCoM5UGKDLM/sn8NlX8QFObdnArCI
         YOzDgYZXT6tSuikq7pxqW1HK6jsSjhOa7f0dWWxrHROQ7yhsPML33i41u3NaH3ABhJB/
         x1TeUyPLvH4Nry9CcPMh72LM6kXIrvFa0bSp1vKqq7oRun0X7EuKj4HUtlzw8iVbdgd3
         zLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=W3a+UOJsNc9ZqMkKYG+PXJQrvd2n9lHBewMUav5hoUo=;
        b=s8v1e7PCVkUqXpLu6fsd2eFmn8kx47ebcpLilBKb+wEE0kUO3SVVI7hpk7uECP3lPC
         oUlMDiqGa4F8Pj5in2DyztOliQv1ZzgatRd8qcS80CvqzUjag9Tpz3O5v+uNmA5iLolh
         +kxeq9Wj5MjGthideYDopwHlhM9DVMiT0jYs/cTnoLkoDoKsoZO7MdXSnpVN8o6raMd+
         sfSd1MLJS0OuWoeellt8w4EDOiuCuw01zJMdvcRaW4+OSRrq3qVsFDn4gdQylb0xcxSH
         k0g9IVh60Ca1U0lGS1ejd4z4HvBvrW6yvs5fuAF3KdgxWFeun92+yeM4bn7384r6RHPY
         PjMQ==
X-Gm-Message-State: AOAM531HYFPv2Pkt5E/11FsgV1O2MXPyoxf7WAVWOIQQn+MKe/EbxBIL
        fkDqaSlx+uA9FtkEmosrE+nq4MGFgD81o6u64bg=
X-Google-Smtp-Source: ABdhPJwKPddQyyKhWn9zElPKGQgwlJVyJPP8r6DDIACNMH48W70Vpw8SHkun9msymqG8oW8DTeNI8HzcT1S63umc5nw=
X-Received: by 2002:a67:e18e:: with SMTP id e14mr21013796vsl.49.1639272327471;
 Sat, 11 Dec 2021 17:25:27 -0800 (PST)
MIME-Version: 1.0
Sender: mcdonnalouise@gmail.com
Received: by 2002:a05:612c:197:b0:23d:f525:588 with HTTP; Sat, 11 Dec 2021
 17:25:27 -0800 (PST)
From:   Jackie Fowler <jackiefowler597@gmail.com>
Date:   Sun, 12 Dec 2021 01:25:27 +0000
X-Google-Sender-Auth: xcLgkLgyadRK327nJNFCjoCbzDw
Message-ID: <CAPVGnmVuwzayZcb6num-u2zvP_RYdxGehOe-LKEtB6FXJGgr4Q@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Gooday dear,

  I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Ms.Jackie Fowler,a widow and citizen of
Canada.I am suffering from a long time brain tumor, It has defiled all
forms of medical treatment, and right now I have about a few months to
leave, according to medical experts. The situation has gotten
complicated recently with my inability to hear proper, am
communicating with you with the help of the chief nurse herein the
hospital, from all indication my conditions is really deteriorating
and it is quite obvious that, according to my doctors they have
advised me that I may not live too long, Because this illness has
gotten to a very bad stage. I plead that you will not expose or betray
this trust and confidence that I am about to repose on you for the
mutual benefit of the orphans and the less privilege. I have some
funds I inherited from my late husband, the sum of ($ 12,500,000.00
Dollars).Having known my condition, I decided to donate this fund to
you believing that you will utilize it the way i am going to instruct
herein.

 I need you to assist me and reclaim this money and use it for Charity
works, for orphanages and gives justice and help to the poor, needy
and widows says The Lord." Jeremiah 22:15-16.=E2=80=9C and also build schoo=
ls
for less privilege that will be named after my late husband if
possible and to promote the word of God and the effort that the house
of God is maintained. I do not want a situation where this money will
be used in an ungodly manner. That's why I'm taking this decision. I'm
not afraid of death, so I know where I'm going. I accept this decision
because I do not have any child who will inherit this money after I
die. Please I want your sincerely and urgent answer to know if you
will be able to execute this project for the glory of God, and I will
give you more information on how the fund will be transferred to your
bank account. May the grace, peace, love and the truth in the Word of
God be with you and all those that you love and care for.
I'm waiting for your immediate reply.
Best Regard's.
Ms.Jackie Fowler.
Writting From the hospital.
May God Bless you,
