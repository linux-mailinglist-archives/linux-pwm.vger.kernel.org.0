Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4266061EA86
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Nov 2022 06:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiKGFie (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Nov 2022 00:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiKGFic (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Nov 2022 00:38:32 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3122D38A7
        for <linux-pwm@vger.kernel.org>; Sun,  6 Nov 2022 21:38:30 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id z14so14558630wrn.7
        for <linux-pwm@vger.kernel.org>; Sun, 06 Nov 2022 21:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fuJxEvQ8hWJBVA+YQn5WV9w4flp3A4j0tI4rSSd1Ck=;
        b=CPJknGh76GKBqj/JyzrYpfhZTA4iLOZ7pJx8SQi6I9UWC5yUQMpW16eNZKtSj1pHns
         MxabvoZfAispcp4LT9u7H76KkohJEq+W1LOk7tp+rdt2UeJNaaqabgllcnG7+0wV3DKS
         E3CI+4Fo1UvFZt+OetXKS1zqc9h4aEFJfQ2JibgX550/Ah9y/5o7KaTEeZUW6BGYcOmK
         l7UISNPT8V+NkmCarotVjJVsCuoc5ydJ8yZOodm5O6FLxOY+86cPGmRQ9l3HA0PDBUCj
         8C7yOfSdUCec7RqHH9C0uuHHlHW3tqR//xHBnzOyD5zwbn98F4B1IWNcLFIt+Qlybh26
         6apQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/fuJxEvQ8hWJBVA+YQn5WV9w4flp3A4j0tI4rSSd1Ck=;
        b=3PdkNKR56kZ8gHWCsiQw7nmgiArv03VvtzM062eXiRLBDtC1LikduzAKD/E8XZDzR3
         FgomeZ/8Le7i592IFXUwKAUP2zDhEvFRNVzPZBRVuIrDfTSpawUx+L5cOMll8w3fyGH8
         iCXLLYqIPyIHedBVE4ayG4WHssxwdeDDxLNSE1KAI1nHyHtzlIKOTHB5yXiWHWVZny7I
         uS7RoRTWs7mdwlL88+7++P7zhnk7B2Kxfpmm0eoW92Q7Bj/68Fw8iG8X+iXM+jZpeLwa
         iG6bcfN4AIY32ftqutJKJzzI1hZJX0yRRruYpPBttEY9sKMmx2uJKHWMZ1wzpCyuG0Mk
         nx4g==
X-Gm-Message-State: ACrzQf1lJHErZ/EDW+ohxz3h7AcE0Kx6ZQGzNvAHHebjOy3ggT5SWNuP
        BWuOm2zKF5LKONAB+4kF/HpfAjyRfCTxqTmIJF4=
X-Google-Smtp-Source: AMsMyM6+M2K/rpCN/oYhU/3GtXRvPMP688eLkiH5jTpblIC8wN5UdW0f/9qta3jzxbRjKwe06xPLl3fydUe2rzMVCKw=
X-Received: by 2002:a5d:47aa:0:b0:236:7a97:7dde with SMTP id
 10-20020a5d47aa000000b002367a977ddemr30073051wrb.625.1667799509089; Sun, 06
 Nov 2022 21:38:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6000:15ca:0:0:0:0 with HTTP; Sun, 6 Nov 2022 21:38:28
 -0800 (PST)
Reply-To: seyba_daniel@yahoo.com
From:   Seyba Daniel <latifatonde4@gmail.com>
Date:   Mon, 7 Nov 2022 06:38:28 +0100
Message-ID: <CAFBpD=O_oWBM3Jd24LGPjrfN1QvDPqX2NMXcnXOiPQmgLR5VZw@mail.gmail.com>
Subject: HELLO,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:444 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7576]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [latifatonde4[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [latifatonde4[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it, which you will
be communicated in details upon response.

My dearest regards

Seyba Daniel
