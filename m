Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3759AA67
	for <lists+linux-pwm@lfdr.de>; Sat, 20 Aug 2022 03:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241413AbiHTBPU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Aug 2022 21:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHTBPT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Aug 2022 21:15:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0C4D176
        for <linux-pwm@vger.kernel.org>; Fri, 19 Aug 2022 18:15:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso9040069pjk.0
        for <linux-pwm@vger.kernel.org>; Fri, 19 Aug 2022 18:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=GyIdygXpERIYq0zhovmgdDSjsG4Trhk4Rphv5GwxReI=;
        b=OskaUT25Ml1j6SJGRfesbUO39qWbANrmUn5D2ZyLiH8H8ulJxRV/3INsDklikhozwj
         RRUvl6MVWmNPFSl8m3IWhbGLl9LHrzbVMmBuLWuh9O+TOCAWQUO+ngo5hah5nod/KRH/
         /J2ID/vHypkk65gqWt4Fz0Jk5UYIOV94pfPAIWiGSDotocqM7By8RbQ1R5AmhRCS0olj
         54M6qvpi8SwCycqs7itlmDsSQYwrVa6JdeeSXNZSMJfiQ1Vj3Ogg/q5ut6OjF80MQsZK
         Fpl8dKmiXjet/CpguND3G8BEXRjZ1j5Hr5HbXqJfZO0AhEOqeSDgMRJjMddQjGEpuEJY
         FPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GyIdygXpERIYq0zhovmgdDSjsG4Trhk4Rphv5GwxReI=;
        b=N3BJSomzOtpwMTQtIhLN36jkgEoYpd87jO0UuDMnP2XcvWmSquosw1cs6kzuq27+mw
         d3yRWMwlaiLyUUddsgqD5lLE3MgaY6sDw2kRX+C1nWjT486yyzmmZMqhIWJ/v6Uyqt0X
         ooGWV6NIrVIC7wG+MxKd7OOaLIgeVykgag2qt7ceBwNmwDGLCSr7J1Trq7OD2W5comPA
         3JCvU89YRF5oBq7aErg5bXAvUKnAvvaaZL7oFEcQLWZoOFRBI7Ccdvi6xmsYhJvS21vS
         YA6+0K1ulTNAtue2fWSQQQbwJ7YNLeUdpbhaZI6xkRUUPzz8ivv+qyxEsLBTIrhQYYfE
         lX8g==
X-Gm-Message-State: ACgBeo1Ka/OlfOrDuSQ49/PTQEImZ57BWOL20vgzREKraFCyVh6wsdsl
        7vmUKJ2ikdZI9yzT9evt5/LPvUe9QuweHvtfdF0=
X-Google-Smtp-Source: AA6agR4vaQgAfCxtaenQIIa2v59ZGfOiiyNTZuRve53RLJp0M3B5lqO3d9wPZgBCRBqreToIcTezTHQmL9W5pw0him4=
X-Received: by 2002:a17:90a:c782:b0:1f7:a4ed:11a1 with SMTP id
 gn2-20020a17090ac78200b001f7a4ed11a1mr11505128pjb.12.1660958118670; Fri, 19
 Aug 2022 18:15:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:d4d2:b0:16e:fde3:172d with HTTP; Fri, 19 Aug 2022
 18:15:18 -0700 (PDT)
Reply-To: aseanvietnam55@gmail.com
From:   ASEAN VIETNAM <yawoarouna@gmail.com>
Date:   Sat, 20 Aug 2022 01:15:18 +0000
Message-ID: <CABoxYe3R_nHxasOOWN5m0wYj_+gKnSGUEqv+xQrVKuEgN2moTw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

--=20
Hello,

You have an important message get back to me for more information.

Mr. Le Luong Minh
(Ph=C3=B3 C=E1=BB=A5c Ng=C3=A2n kh=E1=BB=91) Deputy Department of the Treas=
ury
Vietnam.
