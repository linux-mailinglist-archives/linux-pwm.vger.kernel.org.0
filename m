Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38D65B3E78
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Sep 2022 20:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiIISDu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Sep 2022 14:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiIISDs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Sep 2022 14:03:48 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3BF6C76F
        for <linux-pwm@vger.kernel.org>; Fri,  9 Sep 2022 11:03:47 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id v15so1827430qvi.11
        for <linux-pwm@vger.kernel.org>; Fri, 09 Sep 2022 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=tZOGbBG1Sz4Crh3myx+VI4GFHPnZMYPEGmfQNkYU6/M=;
        b=KoEcCeRVsKOmbPBASGfArKPyPk5xgU+ECrGcQ4BRqFMT8mIA8HwY3xozuzl3DR/cvT
         qHrJasTJRPWjlXR0K2/yZ2aISF5wAOWAZynexZfHpxReP/ZSXSWLzknKb95aqeQQU2+8
         adM1VcfGMdaYaxMLLXIt5woL4SOfj8IkUSF9/rpIkHjBEfYj9+hOXmHdNIbDx3B8iWZz
         vWSvR/8POgCqvONPy49R9j2gfmHTE9JYQiWwnqO/6nmEFvuyNwWiDXv0npL6hqPLmw64
         QwIOn0t64T4BYvIWrzBMb5fZWGEo8gN1FiVUs2fgoCjFqqZDlsieuTbEg9kIDXrunU8V
         JxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tZOGbBG1Sz4Crh3myx+VI4GFHPnZMYPEGmfQNkYU6/M=;
        b=rVZKxmDHMTjWmKWgKORlfcToZcF9A3+4704kGDVxIYc1sbD8tWXYnjuK3xU3mGypkk
         HyyXpXGBXcIOXFCfvFds3rMyTtWgNBggZZG9mBjTjSUJqmdTP1S3ykw7VWLlyL55UL2K
         vnvfwrOgtdInvzuX6H+SyrAqgbamtJr/PcD5UOrujo/nGkgEIZmFlegBBhN096hVbE5S
         Jf8sQCX0Qs1Ual1HvjFocJ6iUDuN8LEQ+P6r1tP9hfJJ7RbaFoYZiqsjswl+KaiOvwCv
         qfg2JRgG9V0/J/nUZwAdyLCuU7LtLiAWKjalNQ/F9cWIXbNFbCjVL6lUDzYSPOfQ8guT
         iX9Q==
X-Gm-Message-State: ACgBeo2VnD7aV/rN35zV/+GhnM5iOoYS4xQarZ01dIJYo1/mgMPN60Lq
        wwWDbfIUeukx/MBV2XZQDKlW/UDCLZX3pX6kVI8=
X-Google-Smtp-Source: AA6agR4Tom9PzBBE3BMIBe3KOdARp4DxosldMNkhAulmkRIme8rRzgUmwPID1FXp5AxfG3zLlhVUyQX4pNd/yEqC2ik=
X-Received: by 2002:a05:6214:e82:b0:4a0:cbae:2690 with SMTP id
 hf2-20020a0562140e8200b004a0cbae2690mr13933462qvb.81.1662746625690; Fri, 09
 Sep 2022 11:03:45 -0700 (PDT)
MIME-Version: 1.0
Sender: elisabethj451@gmail.com
Received: by 2002:ad4:5be1:0:0:0:0:0 with HTTP; Fri, 9 Sep 2022 11:03:45 -0700 (PDT)
From:   Doris David <mrs.doris.david02@gmail.com>
Date:   Fri, 9 Sep 2022 11:03:45 -0700
X-Google-Sender-Auth: OgLlyF7dTVeMjCGdmuqm8QRzgHU
Message-ID: <CAP7Jaw7eUogUfmr3E35pOMxZxFH+EAzBNVu7P1PSApb4tVxJyw@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f2a listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9301]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [elisabethj451[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [elisabethj451[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
Mrs.David Doris, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of ($11,000 000
00) my Doctor told me recently that I have serious sickness which is a
cancer problem. What disturbs me most is my stroke sickness. Having
known my condition, I decided to donate this fund to a good person
that will utilize it the way I am going to instruct herein. I need a
very Honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
Mrs.David Doris,
