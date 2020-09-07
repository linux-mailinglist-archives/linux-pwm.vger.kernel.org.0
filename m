Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27B225F6D8
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Sep 2020 11:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgIGJtx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Sep 2020 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgIGJtw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Sep 2020 05:49:52 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9FDC061755
        for <linux-pwm@vger.kernel.org>; Mon,  7 Sep 2020 02:49:52 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e14so7045494vsa.9
        for <linux-pwm@vger.kernel.org>; Mon, 07 Sep 2020 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kzqniENsjTGrtzwAWBHSHJGSg8nw3GAQdgvThPSbJ54=;
        b=lgt+hVRje3zM3OoS3Ku0gij9Z2FNqL4Q2eL2dP9ugcLQ8yXwOh4Izl2xR9RXzYZ+Bb
         Dzk+Jpag7luj6P1fy0WNpX0N8bNHwKYowOzaoYtlmVO/eu8lNPmQzJSTET+8DH7Z1gMn
         Bm6ta2zrhJY+7vT0JmpuDWThOYVxtu3kSbBYptL1cutlrJIM7b6i8Su+JPd426asO0Ef
         Yv248jGQz9bG5PXf+EQKLHzaeegMaOpkpjbiHAVAZMUHofeINGf9Ah1JEkcn/V95/YI7
         MMN2cSA1B1FIalr7gj9+lmD50nAlldWEo10HHysYmgRgdl1ga/951vKObcatTpZmhgoj
         iKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=kzqniENsjTGrtzwAWBHSHJGSg8nw3GAQdgvThPSbJ54=;
        b=haxm2K7IxUYII+2TcC9IbNJCBRR8xBbPm97q54+DHSLazwUSKrc6tgWIVkssG//hC+
         rgi5E60VBTYNPVDJ2zCIxN67pyuhC+1VT0LlgFJl+sD1rX58PEQkXM/oy8GeF4NV12E8
         +gUEUBnH48O0c0ryyAEdekyz5IXRy10LLi61TKhMH1F5Jw+/sDBE6BkBurCltRoUH6Cv
         e3kOXqk9H2qzwGdX1RZuNeeADb6AY53Z87KuYXmZCTIWUM8YYHcqX5ZnlppXCynUoh/9
         SgCVjxM6vFwcgQMxntwtPlLPjRYv4Af3PUoz8vBa35lltH8rmJX9Uib8xp+LROqwk0Kh
         dKCg==
X-Gm-Message-State: AOAM533DdzFLUzqvdAdPA/1ifizUfejtGtEDrbPe8w9MIq4DcgivGY9A
        QfSK14nk2KZlGVvJ7RYoRVB1TXu5vbEvIP9abh8=
X-Google-Smtp-Source: ABdhPJx8PojsLgdRgE71v9E302mF7xFfVc7IMt5FPfbixgvWz6NIHuz8qE7EwZvPNxXY2iP3Mdhs2eOra/xmLzCKnu4=
X-Received: by 2002:a05:6102:372:: with SMTP id f18mr1701368vsa.8.1599472188809;
 Mon, 07 Sep 2020 02:49:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:184c:0:0:0:0:0 with HTTP; Mon, 7 Sep 2020 02:49:48 -0700 (PDT)
Reply-To: mrs.maddalenanicholaus@gmail.com
From:   "Mrs. Maddalena Nicholaus" <dickksonpaulchambers@gmail.com>
Date:   Mon, 7 Sep 2020 10:49:48 +0100
Message-ID: <CAJTqzoiwvgnwH09Mvr+gaFeMnfawc7j-PuPSaMKXhh6n2sVzWQ@mail.gmail.com>
Subject: =?UTF-8?B?R3LDvMOfZSBMaWViZXI=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Gr=C3=BC=C3=9Fe Lieber,

Ich schreibe diesen Brief mit Tr=C3=A4nen und Trauer und bitte wegen meines
Gesundheitszustands in London um Hilfe. Ich bin Frau Maddalena
Nicholaus, eine 85-j=C3=A4hrige finnische Staatsb=C3=BCrgerin. Ich war eine
Waise, adoptiert von meinem verstorbenen Vater Engr. Joakim Nicholaus,
Vorsitzender und CEO von JNicholaus Oil and Gas Services. Nach dem Tod
meines Vaters folgte ich diesem Beispiel und beschloss zu heiraten,
weil ich sein einziges Kind war.

Bei mir wurde eine isch=C3=A4mische Herzkrankheit diagnostiziert, die mich
viel kostete, und die Komplikationen betrafen alle Teile meines
K=C3=B6rpers und meiner Gehirnzellen. Erst vor 5 Tagen sagten britische
=C3=84rzte, dass ich jederzeit sterben k=C3=B6nnte, weil mein Zustand einen
kritischen Punkt erreicht hatte und sich in einer lebensbedrohlichen
Phase befand. Nachdem ich etwas =C3=BCber meine Gesundheit erfahren hatte,
beschloss ich, Ihre Hilfe / Kooperation zu nutzen, um mein
14,5-Millionen-Dollar-Erbe f=C3=BCr den Bau eines Waisenhauses in meinem
Ged=C3=A4chtnis zu nutzen.

Ich habe diese mutige Entscheidung getroffen, weil ich keinen Ehemann,
keine Familie oder Kinder habe, um Geld zu hinterlassen, wenn ich weg
bin. Wenn Sie interessiert sind, k=C3=B6nnen Sie 30% des Gesamtbetrags f=C3=
=BCr
Hilfe nehmen und den Rest in meinen Erinnerungen verwenden, um
Waisenh=C3=A4user zu bauen. Wenn Sie interessiert sind, kontaktieren Sie
mich bitte bald f=C3=BCr weitere Informationen. Ich werde die
Hinterlegungsbescheinigung und die Sterbeurkunde meines Vaters zur
Genehmigung sowie der Bank vorlegen, um Sie als rechtm=C3=A4=C3=9Figen Empf=
=C3=A4nger
des Geldes in meinem Namen zu identifizieren.

Ich habe diese Nachricht aus dem Englischen =C3=BCbersetzt, damit Sie mich
verstehen. Sie k=C3=B6nnen auf Englisch zur=C3=BCckschreiben, wenn Sie vers=
tehen
oder noch auf Deutsch

Ich freue mich auf Ihre schnelle Antwort.

Sch=C3=B6ne Gr=C3=BC=C3=9Fe
Frau Maddalena Nicholaus.
